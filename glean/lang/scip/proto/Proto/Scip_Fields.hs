{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}

{- This file was auto-generated from scip.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Scip_Fields where
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
arguments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "arguments" a) =>
  Lens.Family2.LensLike' f s a
arguments = Data.ProtoLens.Field.field @"arguments"
code ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "code" a) =>
  Lens.Family2.LensLike' f s a
code = Data.ProtoLens.Field.field @"code"
descriptors ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "descriptors" a) =>
  Lens.Family2.LensLike' f s a
descriptors = Data.ProtoLens.Field.field @"descriptors"
diagnostics ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "diagnostics" a) =>
  Lens.Family2.LensLike' f s a
diagnostics = Data.ProtoLens.Field.field @"diagnostics"
disambiguator ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "disambiguator" a) =>
  Lens.Family2.LensLike' f s a
disambiguator = Data.ProtoLens.Field.field @"disambiguator"
displayName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "displayName" a) =>
  Lens.Family2.LensLike' f s a
displayName = Data.ProtoLens.Field.field @"displayName"
documentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "documentation" a) =>
  Lens.Family2.LensLike' f s a
documentation = Data.ProtoLens.Field.field @"documentation"
documents ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "documents" a) =>
  Lens.Family2.LensLike' f s a
documents = Data.ProtoLens.Field.field @"documents"
enclosingRange ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "enclosingRange" a) =>
  Lens.Family2.LensLike' f s a
enclosingRange = Data.ProtoLens.Field.field @"enclosingRange"
enclosingSymbol ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "enclosingSymbol" a) =>
  Lens.Family2.LensLike' f s a
enclosingSymbol = Data.ProtoLens.Field.field @"enclosingSymbol"
externalSymbols ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "externalSymbols" a) =>
  Lens.Family2.LensLike' f s a
externalSymbols = Data.ProtoLens.Field.field @"externalSymbols"
isDefinition ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isDefinition" a) =>
  Lens.Family2.LensLike' f s a
isDefinition = Data.ProtoLens.Field.field @"isDefinition"
isImplementation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isImplementation" a) =>
  Lens.Family2.LensLike' f s a
isImplementation = Data.ProtoLens.Field.field @"isImplementation"
isReference ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isReference" a) =>
  Lens.Family2.LensLike' f s a
isReference = Data.ProtoLens.Field.field @"isReference"
isTypeDefinition ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isTypeDefinition" a) =>
  Lens.Family2.LensLike' f s a
isTypeDefinition = Data.ProtoLens.Field.field @"isTypeDefinition"
kind ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "kind" a) =>
  Lens.Family2.LensLike' f s a
kind = Data.ProtoLens.Field.field @"kind"
language ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "language" a) =>
  Lens.Family2.LensLike' f s a
language = Data.ProtoLens.Field.field @"language"
manager ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "manager" a) =>
  Lens.Family2.LensLike' f s a
manager = Data.ProtoLens.Field.field @"manager"
maybe'metadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'metadata" a) =>
  Lens.Family2.LensLike' f s a
maybe'metadata = Data.ProtoLens.Field.field @"maybe'metadata"
maybe'package ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'package" a) =>
  Lens.Family2.LensLike' f s a
maybe'package = Data.ProtoLens.Field.field @"maybe'package"
maybe'signatureDocumentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'signatureDocumentation" a) =>
  Lens.Family2.LensLike' f s a
maybe'signatureDocumentation
  = Data.ProtoLens.Field.field @"maybe'signatureDocumentation"
maybe'toolInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'toolInfo" a) =>
  Lens.Family2.LensLike' f s a
maybe'toolInfo = Data.ProtoLens.Field.field @"maybe'toolInfo"
message ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "message" a) =>
  Lens.Family2.LensLike' f s a
message = Data.ProtoLens.Field.field @"message"
metadata ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "metadata" a) =>
  Lens.Family2.LensLike' f s a
metadata = Data.ProtoLens.Field.field @"metadata"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
occurrences ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "occurrences" a) =>
  Lens.Family2.LensLike' f s a
occurrences = Data.ProtoLens.Field.field @"occurrences"
overrideDocumentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "overrideDocumentation" a) =>
  Lens.Family2.LensLike' f s a
overrideDocumentation
  = Data.ProtoLens.Field.field @"overrideDocumentation"
package ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "package" a) =>
  Lens.Family2.LensLike' f s a
package = Data.ProtoLens.Field.field @"package"
positionEncoding ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "positionEncoding" a) =>
  Lens.Family2.LensLike' f s a
positionEncoding = Data.ProtoLens.Field.field @"positionEncoding"
projectRoot ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "projectRoot" a) =>
  Lens.Family2.LensLike' f s a
projectRoot = Data.ProtoLens.Field.field @"projectRoot"
range ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "range" a) =>
  Lens.Family2.LensLike' f s a
range = Data.ProtoLens.Field.field @"range"
relationships ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "relationships" a) =>
  Lens.Family2.LensLike' f s a
relationships = Data.ProtoLens.Field.field @"relationships"
relativePath ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "relativePath" a) =>
  Lens.Family2.LensLike' f s a
relativePath = Data.ProtoLens.Field.field @"relativePath"
scheme ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "scheme" a) =>
  Lens.Family2.LensLike' f s a
scheme = Data.ProtoLens.Field.field @"scheme"
severity ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "severity" a) =>
  Lens.Family2.LensLike' f s a
severity = Data.ProtoLens.Field.field @"severity"
signatureDocumentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "signatureDocumentation" a) =>
  Lens.Family2.LensLike' f s a
signatureDocumentation
  = Data.ProtoLens.Field.field @"signatureDocumentation"
source ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "source" a) =>
  Lens.Family2.LensLike' f s a
source = Data.ProtoLens.Field.field @"source"
suffix ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "suffix" a) =>
  Lens.Family2.LensLike' f s a
suffix = Data.ProtoLens.Field.field @"suffix"
symbol ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "symbol" a) =>
  Lens.Family2.LensLike' f s a
symbol = Data.ProtoLens.Field.field @"symbol"
symbolRoles ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "symbolRoles" a) =>
  Lens.Family2.LensLike' f s a
symbolRoles = Data.ProtoLens.Field.field @"symbolRoles"
symbols ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "symbols" a) =>
  Lens.Family2.LensLike' f s a
symbols = Data.ProtoLens.Field.field @"symbols"
syntaxKind ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "syntaxKind" a) =>
  Lens.Family2.LensLike' f s a
syntaxKind = Data.ProtoLens.Field.field @"syntaxKind"
tags ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "tags" a) =>
  Lens.Family2.LensLike' f s a
tags = Data.ProtoLens.Field.field @"tags"
text ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "text" a) =>
  Lens.Family2.LensLike' f s a
text = Data.ProtoLens.Field.field @"text"
textDocumentEncoding ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "textDocumentEncoding" a) =>
  Lens.Family2.LensLike' f s a
textDocumentEncoding
  = Data.ProtoLens.Field.field @"textDocumentEncoding"
toolInfo ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "toolInfo" a) =>
  Lens.Family2.LensLike' f s a
toolInfo = Data.ProtoLens.Field.field @"toolInfo"
vec'arguments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'arguments" a) =>
  Lens.Family2.LensLike' f s a
vec'arguments = Data.ProtoLens.Field.field @"vec'arguments"
vec'descriptors ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'descriptors" a) =>
  Lens.Family2.LensLike' f s a
vec'descriptors = Data.ProtoLens.Field.field @"vec'descriptors"
vec'diagnostics ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'diagnostics" a) =>
  Lens.Family2.LensLike' f s a
vec'diagnostics = Data.ProtoLens.Field.field @"vec'diagnostics"
vec'documentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'documentation" a) =>
  Lens.Family2.LensLike' f s a
vec'documentation = Data.ProtoLens.Field.field @"vec'documentation"
vec'documents ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'documents" a) =>
  Lens.Family2.LensLike' f s a
vec'documents = Data.ProtoLens.Field.field @"vec'documents"
vec'enclosingRange ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'enclosingRange" a) =>
  Lens.Family2.LensLike' f s a
vec'enclosingRange
  = Data.ProtoLens.Field.field @"vec'enclosingRange"
vec'externalSymbols ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'externalSymbols" a) =>
  Lens.Family2.LensLike' f s a
vec'externalSymbols
  = Data.ProtoLens.Field.field @"vec'externalSymbols"
vec'occurrences ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'occurrences" a) =>
  Lens.Family2.LensLike' f s a
vec'occurrences = Data.ProtoLens.Field.field @"vec'occurrences"
vec'overrideDocumentation ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'overrideDocumentation" a) =>
  Lens.Family2.LensLike' f s a
vec'overrideDocumentation
  = Data.ProtoLens.Field.field @"vec'overrideDocumentation"
vec'range ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'range" a) =>
  Lens.Family2.LensLike' f s a
vec'range = Data.ProtoLens.Field.field @"vec'range"
vec'relationships ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'relationships" a) =>
  Lens.Family2.LensLike' f s a
vec'relationships = Data.ProtoLens.Field.field @"vec'relationships"
vec'symbols ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'symbols" a) =>
  Lens.Family2.LensLike' f s a
vec'symbols = Data.ProtoLens.Field.field @"vec'symbols"
vec'tags ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'tags" a) =>
  Lens.Family2.LensLike' f s a
vec'tags = Data.ProtoLens.Field.field @"vec'tags"
version ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "version" a) =>
  Lens.Family2.LensLike' f s a
version = Data.ProtoLens.Field.field @"version"
