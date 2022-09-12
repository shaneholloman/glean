# @generated
# To regenerate this file run fbcode//glean/schema/gen/sync
from typing import Optional, Tuple, Union, List, Dict, TypeVar
from thrift.py3 import Struct
from enum import Enum
import ast
from glean.schema.py.glean_schema_predicate import GleanSchemaPredicate, angle_for, R, Just, InnerGleanSchemaPredicate
from glean.schema.py.src import *


from glean.schema.testinfra.types import (
    CoveredFile,
    AssemblyByTag,
    TestId,
    MeasuredFileOnly,
    CoveredOrLoadedFileTestIds,
    CoveredFileByPushBlockingAssembly,
    CoveredFileTestIds,
    DatabaseMetadataField,
    CoveredAssembly,
    CoveredFileTestIds,
    TaggedAssembly,
    FileMetadata,
    DatabaseMetadata,
    CoveredFolder,
    CoveredFileByTagAndAssembly,
    FbId,
    CoveredFileOnly,
    Assemblies,
    FileMetadata,
    Folder,
    AssemblyId,
    MeasuredFile,
    ContainsPushBlockingAssembly,
    Tag,
    CoveredFileAssemblies,
    HashAlgo,
    CoverageRange,
    OffsetSpan,
    CoverageGranularity,
    FileLength,
    FileHash,
)


class TestinfraCoveredFile(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, coverage: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFile.3 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, coverage, 'coverage')])) or '_' } }}", CoveredFile

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, coverage: Optional["TestinfraCoverageGranularity"] = None) -> "TestinfraCoveredFile":
    raise Exception("this function can only be called from @angle_query")



class TestinfraAssemblyByTag(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], tag: ast.Expr, testId: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.AssemblyByTag.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, tag, 'tag'), angle_for(__env, testId, 'testId')])) or '_' } }}", AssemblyByTag

  @staticmethod
  def angle_query(*, tag: Optional["TestinfraTag"] = None, testId: Optional["TestinfraAssemblyId"] = None) -> "TestinfraAssemblyByTag":
    raise Exception("this function can only be called from @angle_query")



class TestinfraTestId(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.TestId.1 { angle_for(__env, arg, None) or '_' }", TestId

  @staticmethod
  def angle_query(*, arg: Optional[int] = None) -> "TestinfraTestId":
    raise Exception("this function can only be called from @angle_query")



class TestinfraMeasuredFileOnly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], measuredFile: ast.Expr, file: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.MeasuredFileOnly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, measuredFile, 'measuredFile'), angle_for(__env, file, 'file')])) or '_' } }}", MeasuredFileOnly

  @staticmethod
  def angle_query(*, measuredFile: Optional["TestinfraMeasuredFile"] = None, file: Optional["SrcFile"] = None) -> "TestinfraMeasuredFileOnly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredOrLoadedFileTestIds(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, assemblies: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredOrLoadedFileTestIds.5 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, assemblies, 'assemblies')])) or '_' } }}", CoveredOrLoadedFileTestIds

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, assemblies: Optional["TestinfraTestId"] = None) -> "TestinfraCoveredOrLoadedFileTestIds":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileByPushBlockingAssembly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], coveredFile: ast.Expr, assemblyId: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileByPushBlockingAssembly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, coveredFile, 'coveredFile'), angle_for(__env, assemblyId, 'assemblyId')])) or '_' } }}", CoveredFileByPushBlockingAssembly

  @staticmethod
  def angle_query(*, coveredFile: Optional["TestinfraCoveredFile"] = None, assemblyId: Optional["TestinfraAssemblyId"] = None) -> "TestinfraCoveredFileByPushBlockingAssembly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileTestIds(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, assemblies: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileTestIds.5 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, assemblies, 'assemblies')])) or '_' } }}", CoveredFileTestIds

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, assemblies: Optional["TestinfraTestId"] = None) -> "TestinfraCoveredFileTestIds":
    raise Exception("this function can only be called from @angle_query")



class TestinfraDatabaseMetadataField(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.DatabaseMetadataField.4 { angle_for(__env, arg, None) or '_' }", DatabaseMetadataField

  @staticmethod
  def angle_query(*, arg: Optional[str] = None) -> "TestinfraDatabaseMetadataField":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredAssembly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], assemblyId: ast.Expr, root: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredAssembly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, assemblyId, 'assemblyId'), angle_for(__env, root, 'root')])) or '_' } }}", CoveredAssembly

  @staticmethod
  def angle_query(*, assemblyId: Optional["TestinfraAssemblyId"] = None, root: Optional["TestinfraCoveredFolder"] = None) -> "TestinfraCoveredAssembly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileTestIds(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, assemblies: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileTestIds.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, assemblies, 'assemblies')])) or '_' } }}", CoveredFileTestIds

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, assemblies: Optional["TestinfraTestId"] = None) -> "TestinfraCoveredFileTestIds":
    raise Exception("this function can only be called from @angle_query")



class TestinfraTaggedAssembly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], assemblyId: ast.Expr, tag: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.TaggedAssembly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, assemblyId, 'assemblyId'), angle_for(__env, tag, 'tag')])) or '_' } }}", TaggedAssembly

  @staticmethod
  def angle_query(*, assemblyId: Optional["TestinfraAssemblyId"] = None, tag: Optional["TestinfraTag"] = None) -> "TestinfraTaggedAssembly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraFileMetadata(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, hash: ast.Expr, length: ast.Expr, nonexecutableRanges: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.FileMetadata.2 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, hash, 'hash'), angle_for(__env, length, 'length'), angle_for(__env, nonexecutableRanges, 'nonexecutableRanges')])) or '_' } }}", FileMetadata

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, hash: Optional[List["TestinfraFileHash"]] = None, length: Optional[Union[Just["TestinfraFileLength"], Just[None]]] = None, nonexecutableRanges: Optional[Union[Just["TestinfraCoverageRange"], Just[None]]] = None) -> "TestinfraFileMetadata":
    raise Exception("this function can only be called from @angle_query")



class TestinfraDatabaseMetadata(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], field: ast.Expr, serializedValue: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.DatabaseMetadata.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, field, 'field'), angle_for(__env, serializedValue, 'serializedValue')])) or '_' } }}", DatabaseMetadata

  @staticmethod
  def angle_query(*, field: Optional[str] = None, serializedValue: Optional[str] = None) -> "TestinfraDatabaseMetadata":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFolder(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], folder: ast.Expr, folders: ast.Expr, files: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFolder.2 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, folder, 'folder'), angle_for(__env, folders, 'folders'), angle_for(__env, files, 'files')])) or '_' } }}", CoveredFolder

  @staticmethod
  def angle_query(*, folder: Optional["TestinfraFolder"] = None, folders: Optional[List["TestinfraCoveredFolder"]] = None, files: Optional[List["TestinfraCoveredFile"]] = None) -> "TestinfraCoveredFolder":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileByTagAndAssembly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], coveredFile: ast.Expr, tag: ast.Expr, assemblyId: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileByTagAndAssembly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, coveredFile, 'coveredFile'), angle_for(__env, tag, 'tag'), angle_for(__env, assemblyId, 'assemblyId')])) or '_' } }}", CoveredFileByTagAndAssembly

  @staticmethod
  def angle_query(*, coveredFile: Optional["TestinfraCoveredFile"] = None, tag: Optional["TestinfraTag"] = None, assemblyId: Optional["TestinfraAssemblyId"] = None) -> "TestinfraCoveredFileByTagAndAssembly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraFbId(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.FbId.4 { angle_for(__env, arg, None) or '_' }", FbId

  @staticmethod
  def angle_query(*, arg: Optional[int] = None) -> "TestinfraFbId":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileOnly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], coveredFile: ast.Expr, file: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileOnly.3 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, coveredFile, 'coveredFile'), angle_for(__env, file, 'file')])) or '_' } }}", CoveredFileOnly

  @staticmethod
  def angle_query(*, coveredFile: Optional["TestinfraCoveredFile"] = None, file: Optional["SrcFile"] = None) -> "TestinfraCoveredFileOnly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraAssemblies(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.Assemblies.4 { angle_for(__env, arg, None) or '_' }", Assemblies

  @staticmethod
  def angle_query(*, arg: Optional[List["TestinfraCoveredAssembly"]] = None) -> "TestinfraAssemblies":
    raise Exception("this function can only be called from @angle_query")



class TestinfraFileMetadata(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, hash: ast.Expr, length: ast.Expr, nonexecutableRanges: ast.Expr, executableLength: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.FileMetadata.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, hash, 'hash'), angle_for(__env, length, 'length'), angle_for(__env, nonexecutableRanges, 'nonexecutableRanges'), angle_for(__env, executableLength, 'executableLength')])) or '_' } }}", FileMetadata

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, hash: Optional[List["TestinfraFileHash"]] = None, length: Optional[Union[Just["TestinfraFileLength"], Just[None]]] = None, nonexecutableRanges: Optional[Union[Just["TestinfraCoverageRange"], Just[None]]] = None, executableLength: Optional[Union[Just["TestinfraFileLength"], Just[None]]] = None) -> "TestinfraFileMetadata":
    raise Exception("this function can only be called from @angle_query")



class TestinfraFolder(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.Folder.1 { angle_for(__env, arg, None) or '_' }", Folder

  @staticmethod
  def angle_query(*, arg: Optional[str] = None) -> "TestinfraFolder":
    raise Exception("this function can only be called from @angle_query")



class TestinfraAssemblyId(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], testId: ast.Expr, fbId: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.AssemblyId.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, testId, 'testId'), angle_for(__env, fbId, 'fbId')])) or '_' } }}", AssemblyId

  @staticmethod
  def angle_query_testId(*, testId: "TestinfraTestId") -> "TestinfraAssemblyId":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_fbId(*, fbId: "TestinfraFbId") -> "TestinfraAssemblyId":
    raise Exception("this function can only be called from @angle_query")




class TestinfraMeasuredFile(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, assemblies: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.MeasuredFile.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, assemblies, 'assemblies')])) or '_' } }}", MeasuredFile

  @staticmethod
  def angle_query(*, file: Optional["SrcFile"] = None, assemblies: Optional["TestinfraAssemblies"] = None) -> "TestinfraMeasuredFile":
    raise Exception("this function can only be called from @angle_query")



class TestinfraContainsPushBlockingAssembly(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], assemblies: ast.Expr, assembly: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.ContainsPushBlockingAssembly.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, assemblies, 'assemblies'), angle_for(__env, assembly, 'assembly')])) or '_' } }}", ContainsPushBlockingAssembly

  @staticmethod
  def angle_query(*, assemblies: Optional["TestinfraAssemblies"] = None, assembly: Optional["TestinfraAssemblyId"] = None) -> "TestinfraContainsPushBlockingAssembly":
    raise Exception("this function can only be called from @angle_query")



class TestinfraTag(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], arg: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.Tag.4 { angle_for(__env, arg, None) or '_' }", Tag

  @staticmethod
  def angle_query(*, arg: Optional[str] = None) -> "TestinfraTag":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoveredFileAssemblies(GleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], coveredFile: ast.Expr, assemblies: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoveredFileAssemblies.4 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, coveredFile, 'coveredFile'), angle_for(__env, assemblies, 'assemblies')])) or '_' } }}", CoveredFileAssemblies

  @staticmethod
  def angle_query(*, coveredFile: Optional["TestinfraCoveredFile"] = None, assemblies: Optional["TestinfraAssemblies"] = None) -> "TestinfraCoveredFileAssemblies":
    raise Exception("this function can only be called from @angle_query")





class TestinfraHashAlgo(Enum):
  crc32 = 0
  md5 = 1
  sha1 = 2

class TestinfraCoverageRange(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], lineRanges: ast.Expr, byteRanges: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoverageRange.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, lineRanges, 'lineRanges'), angle_for(__env, byteRanges, 'byteRanges')])) or '_' } }}", CoverageRange

  @staticmethod
  def angle_query_lineRanges(*, lineRanges: List["TestinfraOffsetSpan"]) -> "TestinfraCoverageRange":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_byteRanges(*, byteRanges: List["TestinfraOffsetSpan"]) -> "TestinfraCoverageRange":
    raise Exception("this function can only be called from @angle_query")




class TestinfraOffsetSpan(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], offsetFromZero: ast.Expr, lengthAtLeastZero: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.OffsetSpan.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, offsetFromZero, 'offsetFromZero'), angle_for(__env, lengthAtLeastZero, 'lengthAtLeastZero')])) or '_' } }}", OffsetSpan

  @staticmethod
  def angle_query(*, offsetFromZero: Optional[int] = None, lengthAtLeastZero: Optional[int] = None) -> "TestinfraOffsetSpan":
    raise Exception("this function can only be called from @angle_query")



class TestinfraCoverageGranularity(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], file: ast.Expr, range: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.CoverageGranularity.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, file, 'file'), angle_for(__env, range, 'range')])) or '_' } }}", CoverageGranularity

  @staticmethod
  def angle_query_file(*, file: bool) -> "TestinfraCoverageGranularity":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_range(*, range: 'TestinfraCoverageGranularity_range') -> "TestinfraCoverageGranularity":
    raise Exception("this function can only be called from @angle_query")


class TestinfraCoverageGranularity_range(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], coveredRanges: ast.Expr, uncoveredRanges: ast.Expr) -> Tuple[str, Struct]:
    return f" {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, coveredRanges, 'coveredRanges'), angle_for(__env, uncoveredRanges, 'uncoveredRanges')])) or '_' } }}", TestinfraCoverageGranularity_range

  @staticmethod
  def angle_query(*, coveredRanges: Optional["TestinfraCoverageRange"] = None, uncoveredRanges: Optional[Union[Just["TestinfraCoverageRange"], Just[None]]] = None) -> "TestinfraCoverageGranularity_range":
    raise Exception("this function can only be called from @angle_query")





class TestinfraFileLength(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], lines: ast.Expr, offset: ast.Expr, lineOffsets: ast.Expr, linesAndOffset: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.FileLength.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, lines, 'lines'), angle_for(__env, offset, 'offset'), angle_for(__env, lineOffsets, 'lineOffsets'), angle_for(__env, linesAndOffset, 'linesAndOffset')])) or '_' } }}", FileLength

  @staticmethod
  def angle_query_lines(*, lines: int) -> "TestinfraFileLength":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_offset(*, offset: int) -> "TestinfraFileLength":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_lineOffsets(*, lineOffsets: List[int]) -> "TestinfraFileLength":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_linesAndOffset(*, linesAndOffset: 'TestinfraFileLength_linesAndOffset') -> "TestinfraFileLength":
    raise Exception("this function can only be called from @angle_query")


class TestinfraFileLength_linesAndOffset(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], lines: ast.Expr, offset: ast.Expr) -> Tuple[str, Struct]:
    return f" {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, lines, 'lines'), angle_for(__env, offset, 'offset')])) or '_' } }}", TestinfraFileLength_linesAndOffset

  @staticmethod
  def angle_query(*, lines: Optional[int] = None, offset: Optional[int] = None) -> "TestinfraFileLength_linesAndOffset":
    raise Exception("this function can only be called from @angle_query")





class TestinfraFileHash(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], algo: ast.Expr, hash: ast.Expr) -> Tuple[str, Struct]:
    return f"testinfra.FileHash.1 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, algo, 'algo'), angle_for(__env, hash, 'hash')])) or '_' } }}", FileHash

  @staticmethod
  def angle_query(*, algo: Optional["TestinfraHashAlgo"] = None, hash: Optional[int] = None) -> "TestinfraFileHash":
    raise Exception("this function can only be called from @angle_query")




