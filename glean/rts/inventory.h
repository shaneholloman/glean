/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include "glean/rts/bytecode/subroutine.h"
#include "glean/rts/bytecode/syscall.h"
#include "glean/rts/fact.h"
#include "glean/rts/id.h"
#include "glean/rts/set.h"

namespace facebook {
namespace glean {
namespace rts {

// NOTE: Any changes here should also be propagated to the internal.thrift
// types and serialize and deserialize should be updated accordingly.
//
// We aren't using the Thrift types here because it isn't clear if those will
// be needed in the long term and it's nice to be able to have methods.

/// Information about a predicate in an open DB.
struct Predicate {
  Pid id;
  std::string name;
  int32_t version;

  // This adds an indirection to the rename call, which is not ideal.
  template <typename F>
  struct Rename : SetOps {
    explicit Rename(F&& rename_fun) : rename_fun(rename_fun) {}

    Id rename(Id id, Pid type) const {
      return rename_fun(id, type);
    }

    F rename_fun;
  };

  template <typename Context>
  using Descend = SysCalls<Context, SysCall<Id, Pid>>;

  /// Typechecker for clauses. It should take the following arguments:
  ///
  /// std::function<Id(Id id, Id type)> - fact substitution
  /// Set syscalls
  /// const void * - begin of clause/key
  /// const void * - end of key/begin of value
  /// const void * - end of clause/value
  /// binary::Output * - substituted clause
  ///
  /// Returns size of substituted key in first result register
  std::shared_ptr<Subroutine> typechecker;

  /// Generic fact traversal. Takes these arguments:
  ///
  /// std::function<void(Id id, Pid type)> - called for each fact ID
  /// const void * - begin of clause/key
  /// const void * - end of key/begin of value
  /// const void * - end of clause/value
  std::shared_ptr<Subroutine> traverser;

  bool operator==(const Predicate& other) const;
  bool operator!=(const Predicate& other) const {
    return !(*this == other);
  }

  template <typename F>
  void typecheck(
      Rename<F>& rename,
      Fact::Clause clause,
      binary::Output& output,
      uint64_t& key_size) const {
    runTypecheck(*typechecker, rename, clause, output, key_size);
  }

  template <typename F>
  void substitute(
      Rename<F>& rename,
      Fact::Clause clause,
      binary::Output& output,
      uint64_t& key_size) const {
    // TODO: We implement substitution via the typechecker for now but it we
    // might want to generate a more efficient subroutine just for substitution.
    typecheck(rename, clause, output, key_size);
  }

  template <typename F>
  static void runTypecheck(
      const Subroutine& sub,
      Rename<F>& rename,
      Fact::Clause clause,
      binary::Output& output,
      uint64_t& key_size) {
    const auto context_ = syscalls<
        &Rename<F>::rename,
        &Rename<F>::newSet,
        &Rename<F>::insertOutputSet,
        &Rename<F>::setToArray,
        &Rename<F>::freeSet,
        &Rename<F>::newWordSet,
        &Rename<F>::insertBytesWordSet,
        &Rename<F>::wordSetToArray,
        &Rename<F>::byteSetToByteArray,
        &Rename<F>::freeWordSet>(rename);

    Subroutine::Activation::with(
        sub, context_.contextptr(), [&](auto& activation) {
          activation.start();
          auto args = activation.args();
          args = std::copy(
              context_.handlers_begin(), context_.handlers_end(), args);
          *args++ = reinterpret_cast<uint64_t>(clause.data);
          *args++ = reinterpret_cast<uint64_t>(clause.data + clause.key_size);
          *args++ = reinterpret_cast<uint64_t>(clause.data + clause.size());

          activation.execute();
          assert(!activation.suspended());

          output = std::move(activation.output(0));
          key_size = activation.results()[0];
        });
  }

  template <typename Context>
  void traverse(const Descend<Context>& descend, Fact::Clause clause) const {
    runTraverse(*traverser, descend, clause);
  }

  template <typename Context>
  static void runTraverse(
      const Subroutine& sub,
      const Descend<Context>& descend,
      Fact::Clause clause) {
    Subroutine::Activation::with(
        sub, descend.contextptr(), [&](auto& activation) {
          activation.run(
              {*descend.handlers_begin(),
               reinterpret_cast<uint64_t>(clause.data),
               reinterpret_cast<uint64_t>(clause.data + clause.key_size),
               reinterpret_cast<uint64_t>(clause.data + clause.size())});
        });
  }
};

/// Information about predicates in an open DB.
struct Inventory {
 public:
  Inventory();

  // The ids in 'predicates' are expected to be mostly dense (gaps are ok for
  // now but the Inventory will use O(max_id - min_id) space.
  explicit Inventory(std::vector<Predicate> predicates);

  const Predicate* FOLLY_NULLABLE lookupPredicate(Pid id) const&;

  Pid firstId() const {
    return first_id;
  }

  Pid firstFreeId() const {
    return firstId() + preds.size();
  }

  // TEMPORARY
  std::vector<const Predicate*> predicates() const;

  std::string serialize() const;
  static Inventory deserialize(folly::ByteRange);

  bool operator==(const Inventory& other) const {
    return first_id == other.first_id && preds == other.preds;
  }
  bool operator!=(const Inventory& other) const {
    return !(*this == other);
  }

 private:
  Pid first_id;
  std::vector<Predicate> preds;
  // an INVALID Predicate::id means there is no predicate with that id
};

} // namespace rts
} // namespace glean
} // namespace facebook
