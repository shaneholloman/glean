{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}

{-# LANGUAGE TypeApplications, ApplicativeDo, PartialTypeSignatures #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module Glean.Glass.Search.Cxx
  ( {- instances -}
  ) where

import Data.Text ( Text )
import qualified Data.Text as Text
import Data.Maybe ( fromMaybe )
import Data.Set ( Set )
import qualified Data.Set as Set

import Glean.Angle as Angle
import Glean.Haxl.Repos (ReposHaxl)

import Glean.Glass.Search.Class
    ( ResultLocation, SearchResult(None), Search(..), searchSymbolId )
import Glean.Glass.Query ( entityLocation )
import qualified Glean.Glass.SymbolId.Cxx.Parse as P

import qualified Glean.Schema.CodeCxx.Types as Cxx
import qualified Glean.Schema.Code.Types as Code
import qualified Glean.Schema.CodemarkupTypes.Types as Code
import qualified Glean.Schema.Cxx1.Types as Cxx
import qualified Glean.Schema.Src.Types as Src
import qualified Glean.Schema.SymbolidCxx.Types as SymbolId

instance Search Cxx.Entity where
  symbolSearch = cxxSymbolSearch

cxxSymbolSearch :: [Text] -> ReposHaxl u w (SearchResult Cxx.Entity)
cxxSymbolSearch t = case P.validateSymbolId t of
  Left err -> return $ None (Text.unlines err)
  Right P.SymbolEnv{..} ->
    let scope = map P.unName scopes
        parameters = map P.unName params
        mname = fmap P.unName localname
    in case tag of
      -- ctors with signatures, ctor params or dtors
      Just P.CTorSignature -- .c
        | declaration -> searchCTorSigDeclarations t path scope parameters
        | otherwise -> searchCTorSigDefinitions t path scope parameters
      Just P.Constructor -- these are always params to constructors now. remove
        | Just name <- mname -- only Nothing in constructor/destructor case
        -> let scope' = scope <> [".ctor"] -- params are within ctor scope
           in searchSymbolId t $ if declaration
            then lookupDeclaration path scope' name
            else lookupDefinition path scope' name
      Just P.Destructor -- destructor (".dtor") decls or definitions
        -> searchSymbolId t $ if declaration
            then lookupDTorDeclaration path scope
            else lookupDTorDefinition path scope
      Just P.Function -- ".f" functions with complete signatures
        | Just name <- mname -- again, never Nothing (no anonymous functions?)
        -> searchSymbolId t $ if declaration
            then lookupFunctionSignatureDeclaration
                      path scope name parameters qualifiers
            else lookupFunctionSignatureDefinition
                   path scope name parameters qualifiers
      -- everything else
      _ -> if declaration
           then searchDeclarations t path scope (fromMaybe "" mname)
           else searchDefinitions t path scope (fromMaybe "" mname)

-- this is the most common path, for e.g. classes and functions
--
-- > fbsource/cpp @ fbcode/folly/Optional/assign
-- > fbsource/cpp @ fbcode/folly/Optional
--
-- would resolve to their definition occurences.
--
-- enumerators (fields of enums) are also in this path
--
searchDefinitions
  :: [Text] -> Text -> [Text] -> Text -> ReposHaxl u w (SearchResult Cxx.Entity)
searchDefinitions t path ns name =
  searchSymbolId t (lookupDefinition path ns name)
    .|?
  searchSymbolId t (lookupFunctionDefinition path ns name)
    .|?
  searchSymbolId t (lookupNamespaceDefinition path ns name)
    .|?
  (if not (null ns)
      then searchSymbolId t (lookupEnumerator path (init ns) (last ns) name)
      else pure $ None "Cxx.searchDefinitions: no results found")

--
-- declaration entities only
--
searchDeclarations
  :: [Text] -> Text -> [Text] -> Text -> ReposHaxl u w (SearchResult Cxx.Entity)
searchDeclarations t path ns name = -- `ns` might be [] for global scope
    searchSymbolId t (lookupDeclaration path ns name)
      .|?
    searchSymbolId t (lookupFunctionDeclaration path ns name)
      .|?
    searchSymbolId t (lookupNamespaceDeclaration path ns name)

searchCTorSigDefinitions
  :: [Text] -> Text -> [Text] -> [Text]
  -> ReposHaxl u w (SearchResult Cxx.Entity)
searchCTorSigDefinitions t path scope sig = searchSymbolId t $
  lookupCTorSignatureDefinition path scope sig

searchCTorSigDeclarations
  :: [Text] -> Text -> [Text] -> [Text]
  -> ReposHaxl u w (SearchResult Cxx.Entity)
searchCTorSigDeclarations t path scope sig = searchSymbolId t $
  lookupCTorSignatureDeclaration path scope sig

--
-- A little `then` or .|. thing for searching until first match
--
(.|?)
  :: ReposHaxl u w (SearchResult t)
  -> ReposHaxl u w (SearchResult t)
  -> ReposHaxl u w (SearchResult t)
a .|? b = do
  v <- a
  case v of
    None{} -> b
    _ -> pure v

------------------------------------------------------------------------

--
-- Records, Variables, Enum, TypeAlias, Using Directives.
--
lookupDefinition :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupDefinition = lookupEntityFn $ \name ns entity ->
  predicate @SymbolId.LookupDefinition (
    rec $
      field @"name" (string name) $
      field @"scope" (scopeQ (reverse ns)) $
      field @"entity" entity
    end)

lookupFunctionDefinition
  :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupFunctionDefinition = lookupEntityFn $ \name ns entity ->
  predicate @SymbolId.LookupFunctionDefinition (
    rec $
      field @"name" (functionName name) $
      field @"scope" (scopeQ (reverse ns)) $
      field @"entity" entity
    end)

lookupNamespaceDefinition
  :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupNamespaceDefinition = lookupEntityFn $ \name ns entity ->
  predicate @SymbolId.LookupNamespaceDefinition (
    rec $
      field @"name" (maybeName name) $
      field @"parent" (namespaceParentQName (reverse ns)) $
      field @"entity" entity
    end)

--
-- enum values (fields of an enumerator) are a bit different again.
-- they are a field in an enum declaration, so to query you need to
-- know the field, and also the parent enum name and scope.
--
lookupEnumerator
  :: Text -> [Text] -> Text -> Text -> Angle (ResultLocation Cxx.Entity)
lookupEnumerator anchor ns parent name =
  vars $ \ (decl :: Angle Cxx.Enumerator) (entity :: Angle Cxx.Entity)
    (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
      (rangespan :: Angle Code.RangeSpan) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupEnumerator (
        rec $
          field @"name" (string name) $
          field @"parent" (string parent) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"decl" (asPredicate decl)
        end))
      : (alt @"enumerator" (asPredicate decl) .= sig entity)
      : entityFooter anchor entity codeEntity file rangespan lname
      )

lookupDTorDeclaration :: Text -> [Text] -> Angle (ResultLocation Cxx.Entity)
lookupDTorDeclaration anchor ns =
  vars $ \(decl :: Angle Cxx.Declaration) (entity :: Angle Cxx.Entity)
     (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
     (rangespan :: Angle Code.RangeSpan) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupFunctionDeclaration (
        rec $
          field @"name" (alt @"destructor" wild) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"decl" decl
        end))
      : entityDeclFooter anchor decl entity codeEntity file rangespan lname
      )

lookupDTorDefinition :: Text -> [Text] -> Angle (ResultLocation Cxx.Entity)
lookupDTorDefinition anchor ns =
  vars $ \(entity :: Angle Cxx.Entity) (codeEntity :: Angle Code.Entity)
     (file :: Angle Src.File) (rangespan :: Angle Code.RangeSpan)
       (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupFunctionDefinition (
        rec $
          field @"name" (alt @"destructor" wild) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"entity" entity
        end))
      : entityFooter anchor entity codeEntity file rangespan lname
      )

lookupCTorSignatureDefinition
  :: Text -> [Text] -> [Text] -> Angle (ResultLocation Cxx.Entity)
lookupCTorSignatureDefinition anchor ns params =
  vars $ \(entity :: Angle Cxx.Entity) (codeEntity :: Angle Code.Entity)
     (file :: Angle Src.File) (rangespan :: Angle Code.RangeSpan)
      (asig :: Angle Cxx.Signature) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ([
      asig .= paramTypesQ params,
      wild .= predicate @SymbolId.LookupFunctionSignatureDefinition (
        rec $
          field @"name" (alt @"constructor" wild) $ -- either @alt ctor or dtor
          field @"scope" (scopeQ (reverse ns)) $
          field @"signature" (asPredicate asig) $
          field @"entity" entity
        end)
      ] <> entityFooter anchor entity codeEntity file rangespan lname)

lookupCTorSignatureDeclaration
  :: Text -> [Text] -> [Text] -> Angle (ResultLocation Cxx.Entity)
lookupCTorSignatureDeclaration anchor ns params =
  vars $ \(decl :: Angle Cxx.Declaration)  (entity :: Angle Cxx.Entity)
      (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
        (asig :: Angle Cxx.Signature) (rangespan :: Angle Code.RangeSpan)
        (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ([
      asig .= paramTypesQ params,
      wild .= predicate @SymbolId.LookupFunctionSignatureDeclaration (
        rec $
          field @"name" (alt @"constructor" wild) $ -- either @alt ctor or dtor
          field @"scope" (scopeQ (reverse ns)) $
          field @"signature" (asPredicate asig) $
          field @"decl" decl
        end)
      ] <> entityDeclFooter anchor decl entity codeEntity file rangespan lname)

lookupFunctionSignatureDeclaration
  :: Text -> [Text] -> Text -> [Text] -> Set P.Qualifier
  -> Angle (ResultLocation Cxx.Entity)
lookupFunctionSignatureDeclaration anchor ns name params quals =
  vars $ \(decl :: Angle Cxx.Declaration)  (entity :: Angle Cxx.Entity)
      (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
        (rangespan :: Angle Code.RangeSpan)
        (fname :: Angle Cxx.FunctionName) (n :: Angle Cxx.Name)
        (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ([
      n .= predicate @Cxx.Name (string name),
      fname .= predicate @Cxx.FunctionName (alt @"name" (asPredicate n)),
      wild .= predicate @SymbolId.LookupFunctionSignatureQualifierDeclaration (
        rec $
          field @"name" (asPredicate fname) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"signature" (asPredicate (paramTypesQ params)) $
          field @"qualifiers" (qualifiersQ quals) $
          field @"decl" decl
        end)
    ] <> entityDeclFooter anchor decl entity codeEntity file rangespan lname)

lookupFunctionSignatureDefinition
  :: Text -> [Text] -> Text -> [Text] -> Set P.Qualifier
  -> Angle (ResultLocation Cxx.Entity)
lookupFunctionSignatureDefinition anchor ns name params quals =
  vars $ \(entity :: Angle Cxx.Entity) (codeEntity :: Angle Code.Entity)
      (file :: Angle Src.File) (rangespan :: Angle Code.RangeSpan)
        (fname :: Angle Cxx.FunctionName) (n :: Angle Cxx.Name)
        (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ([
      n .= predicate @Cxx.Name (string name),
      fname .= predicate @Cxx.FunctionName (alt @"name" (asPredicate n)),
      wild .= predicate @SymbolId.LookupFunctionSignatureQualifierDefinition (
        rec $
          field @"name" (asPredicate fname) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"signature" (asPredicate (paramTypesQ params)) $
          field @"qualifiers" (qualifiersQ quals) $
          field @"entity" entity
        end)
      ] <> entityFooter anchor entity codeEntity file rangespan lname)

--
-- We have four variants, and two ways to resolve each
--
-- - record, variable, enum, type , using
-- - functions (and function-like things)
-- - namespaces
-- - enumerators
--
-- And for the first 3, a defn version as well.
--

--
-- Declarations of records, variables, enums, type , using directives
-- n.b. a lot of variables are not considered "Definitions" (e.g. local/auto)
-- so they are only discoverable through decl search
--
lookupDeclaration
  :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupDeclaration anchor ns name =
  vars $ \ (decl :: Angle Cxx.Declaration) (entity :: Angle Cxx.Entity)
    (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
      (rangespan :: Angle Code.RangeSpan) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupDeclaration (
        rec $
          field @"name" (string name) $
          field @"scope" (scopeQ (reverse ns)) $
          field @"decl" decl
        end))
      : entityDeclFooter anchor decl entity codeEntity file rangespan lname
      )

--
-- Declarations of functions, including regular named functions, operators,
-- literl operators, constructors (anonymous), destructors (anonymous), and
-- type conversion operators.
--
-- Note things like variables, within a function, have a FunctionQName scope
-- but are not FunctionName-indexed
--
lookupFunctionDeclaration
  :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupFunctionDeclaration anchor ns name =
  vars $ \ (decl :: Angle Cxx.Declaration) (entity :: Angle Cxx.Entity)
    (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
      (rangespan :: Angle Code.RangeSpan) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupFunctionDeclaration (
        rec $
          field @"name" (functionName name) $
          -- scopeQuery: too generic? can this ever be local or a function?
          field @"scope" (scopeQ (reverse ns)) $
          field @"decl" decl
        end))
      : entityDeclFooter anchor decl entity codeEntity file rangespan lname
      )

--
-- Namespaces are a bit like regular scopes but they can be anonymous.
-- This is a "" in the symbol id, corresponding to a nothing in the query
--
lookupNamespaceDeclaration
  :: Text -> [Text] -> Text -> Angle (ResultLocation Cxx.Entity)
lookupNamespaceDeclaration anchor ns name =
  vars $ \ (decl :: Angle Cxx.Declaration) (entity :: Angle Cxx.Entity)
    (codeEntity :: Angle Code.Entity) (file :: Angle Src.File)
      (rangespan :: Angle Code.RangeSpan) (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= predicate @SymbolId.LookupNamespaceDeclaration (
        rec $
          field @"name" (maybeName name) $
          field @"parent" (namespaceParentQName (reverse ns)) $
          field @"decl" decl
        end))
      : entityDeclFooter anchor decl entity codeEntity file rangespan lname
      )

--
-- AngleStatement helpers, to generate query fragments
--

lookupEntityFn ::
  Angle.AngleVars
    (Angle Cxx.Entity
      -> Angle Code.Entity
      -> Angle Src.File
      -> Angle Code.RangeSpan
      -> Angle Text
      -> Angle (Cxx.Entity, Src.File, Code.RangeSpan, Text)) r
  => (Text -> [Text] -> Angle Cxx.Entity -> Angle t)
  -> Text -> [Text] -> Text -> r
lookupEntityFn pred anchor ns name =
  vars $ \(entity :: Angle Cxx.Entity) (codeEntity :: Angle Code.Entity)
      (file :: Angle Src.File) (rangespan :: Angle Code.RangeSpan)
      (lname :: Angle Text) ->
    tuple (entity, file, rangespan, lname) `where_` ((
      wild .= pred name ns entity)
      : entityFooter anchor entity codeEntity file rangespan lname
    )

entityDeclFooter
  :: Text -> Angle Cxx.Declaration -> Angle Cxx.Entity -> Angle Code.Entity
  -> Angle Src.File -> Angle Code.RangeSpan -> Angle Text
  -> [AngleStatement]
entityDeclFooter anchor decl entity codeEntity file rangespan lname =
  (alt @"decl" decl .= sig entity)
  : entityFooter anchor entity codeEntity file rangespan lname

entityFooter
  :: Text -> Angle Cxx.Entity -> Angle Code.Entity
  -> Angle Src.File -> Angle Code.RangeSpan -> Angle Text
  -> [AngleStatement]
entityFooter anchor entity codeEntity file rangespan lname =
  [ alt @"cxx" entity .= sig codeEntity
  , entityLocation codeEntity file rangespan lname
  ] ++ -- refine to specific sub-repo if we have a prefix
  [file .= predicate @Src.File (stringPrefix anchor) | not (Text.null anchor)]

--
-- Scope queries
--

-- These will never be empty strings
functionName :: Text -> Angle Cxx.FunctionName_key
functionName name =
  alt @"name" (string name) .|
  alt @"operator_" (string name) .|
  alt @"literalOperator" (string name) .|
  alt @"conversionOperator" (string name)

--
-- For namespaces, which may have anonymous components
--
maybeName :: Text -> Angle (Maybe Cxx.Name)
maybeName "" = nothing
maybeName n = just (predicate (string n))

namespaceParentQName :: [Text] -> Angle (Maybe Cxx.NamespaceQName)
namespaceParentQName [] = nothing
namespaceParentQName (n:ns) = just $ predicate $
  rec $
    field @"name" (maybeName n) $
    field @"parent" (namespaceParentQName ns)
  end

namespaceQName :: [Text] -> Text -> Angle Cxx.NamespaceQName_key
namespaceQName ns n =
  rec $
    field @"name" (maybeName n) $
    field @"parent" (namespaceParentQName ns)
  end

functionQName :: [Text] -> Text -> Angle Cxx.FunctionQName_key
functionQName ns ".ctor" = -- hard coded tokens. fix.
  rec $
    field @"name" (alt @"constructor" wild) $
    field @"scope" (scopeQ ns)
  end
functionQName ns ".dtor" = -- hard coded tokens
  rec $
    field @"name" (alt @"destructor" wild) $
    field @"scope" (scopeQ ns)
  end
functionQName ns n =
  rec $
    field @"name" (functionName n) $ -- i suspect we have params to constrs here
    field @"scope" (scopeQ ns)
  end

--
-- Scope queries. There are lots of alternatives, recursively, unfortunately
--
scopeQ :: [Text] -> Angle Cxx.Scope
scopeQ [] = alt @"global_" wild {- builtin.Unit -}
scopeQ _ss@(n:ns) =
  alt @"namespace_" (namespaceQName ns n)
  .|
  alt @"recordWithAccess" (rec $
      field @"record" (rec $ -- anonymous QName
        field @"name" (string n) $
        field @"scope" (scopeQ ns) -- I suspect this is too generic
      end)
    end)
  .|
  alt @"local" (functionQName ns n) -- too broad, will yield local (global ..)

--
-- cxx1.Signature type only of param queries
--  Fn where S = cxx1.Scope {
--         recordWithAccess = { record = { name = "dynamic",
--          scope = { namespace_ = { name = { just =  "folly" } }}}}};
--   Fn = symbolid.cxx.LookupFunctionDeclaration { name = { constructor = {} },
--        scope = S, decl = { function_ =
--  { signature = { parameters = [{"r","folly::dynamic::Array &&"}] }
-- , source = {file = F } } }}; F = src.File "fbcode/"..
--
-- Note: params are in the non-left position, so this should always be used
-- _after_ matching the FunctionDeclaration
--
paramTypesQ :: [Text] -> Angle Cxx.Signature
paramTypesQ ps = predicate @Cxx.Signature $
    rec $
      field @"parameters" (array (map paramQ ps))
    end
  where
    paramQ :: Text -> Angle Cxx.Parameter
    paramQ tyStr =
      rec $
        field @"type" (string tyStr)
      end

--
-- function signature qualifiers (const &&, volatile etc)
--
qualifiersQ :: Set P.Qualifier -> Angle (Maybe Cxx.MethodSignature)
qualifiersQ qs
  | Set.null qs    -- if there's no qualifiers its either nothing or all false
  = sig nothing .| just (
      rec $
        field @"isVirtual" false $
        field @"isConst" false $
        field @"isVolatile" false $
        field @"refQualifier" (enum Cxx.RefQualifier_None_)
      end)
  | otherwise   -- its definitely set
  = just $ sig $
      rec $
        field @"isVirtual" (bool $ P.Virtual `Set.member` qs) $
        field @"isConst" (bool $ P.Const `Set.member` qs) $
        field @"isVolatile" (bool $ P.Volatile `Set.member` qs) $
        field @"refQualifier" (enum
          (if P.RefQual P.LValue `Set.member` qs
            then Cxx.RefQualifier_LValue
            else if P.RefQual P.RValue `Set.member` qs
            then Cxx.RefQualifier_RValue
            else Cxx.RefQualifier_None_
          ))
      end
