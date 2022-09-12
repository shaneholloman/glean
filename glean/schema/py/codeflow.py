# @generated
# To regenerate this file run fbcode//glean/schema/gen/sync
from typing import Optional, Tuple, Union, List, Dict, TypeVar
from thrift.py3 import Struct
from enum import Enum
import ast
from glean.schema.py.glean_schema_predicate import GleanSchemaPredicate, angle_for, R, Just, InnerGleanSchemaPredicate


from glean.schema.codeflow.types import (
    flowEntity,
)




class CodeFlowEntity(InnerGleanSchemaPredicate):
  @staticmethod
  def build_angle(__env: Dict[str, R], decl: ast.Expr, module_: ast.Expr) -> Tuple[str, Struct]:
    return f"code.flow.Entity.2 {{ { ', '.join(filter(lambda x: x != '', [angle_for(__env, decl, 'decl'), angle_for(__env, module_, 'module_')])) or '_' } }}", flowEntity

  @staticmethod
  def angle_query_decl(*, decl: "FlowSomeDeclaration") -> "CodeFlowEntity":
    raise Exception("this function can only be called from @angle_query")

  @staticmethod
  def angle_query_module_(*, module_: "FlowModule") -> "CodeFlowEntity":
    raise Exception("this function can only be called from @angle_query")





