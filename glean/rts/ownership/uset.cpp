/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include "glean/rts/ownership/uset.h"

namespace facebook {
namespace glean {
namespace rts {

SetExpr<Usets::MutableEliasFanoList> Uset::toEliasFano(UsetId max) const {
  return {exp.op, exp.set.toEliasFano(max)};
}

std::vector<SetExpr<Usets::MutableEliasFanoList>> Usets::toEliasFano(
    UsetId max) {
  std::vector<SetExpr<Usets::MutableEliasFanoList>> sets(stats.promoted);
  for (auto uset : usets) {
    if (uset->promoted()) {
      VLOG(5) << "exporting: " << uset->id;
      sets[uset->id - firstId] = uset->toEliasFano(max);
    }
  }
  return sets;
}

} // namespace rts
} // namespace glean
} // namespace facebook
