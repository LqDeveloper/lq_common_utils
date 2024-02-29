extension SetExtension<T> on Set<T> {
  /// 如果 [this] 和 [other] 包含完全相同的元素，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isEqualTo({'b', 'a', 'c'}); // true
  /// set.isEqualTo({'b', 'a', 'f'}); // false
  /// set.isEqualTo({'a', 'b'}); // false
  /// set.isEqualTo({'a', 'b', 'c', 'd'}); // false
  bool isEqualTo(Set<Object> other) =>
      length == other.length && containsAll(other);

  /// 如果 [this] 和 [other] 没有共同的元素，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isDisjointWith({'d', 'e', 'f'}); // true
  /// set.isDisjointWith({'d', 'e', 'b'}); // false
  bool isDisjointWith(Set<Object> other) => intersection(other).isEmpty;

  /// 如果 [this] 和 [other] 至少有一个共同元素，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isIntersectingWith({'d', 'e', 'b'}); // true
  /// set.isIntersectingWith({'d', 'e', 'f'}); // false
  bool isIntersectingWith(Set<Object> other) => intersection(other).isNotEmpty;

  /// 如果 [this] 的每个元素都包含在 [other] 中，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isSubsetOf({'a', 'b', 'c', 'd'}); // true
  /// set.isSubsetOf({'a', 'b', 'c'}); // true
  /// set.isSubsetOf({'a', 'b', 'f'}); // false
  bool isSubsetOf(Set<Object> other) =>
      length <= other.length && other.containsAll(this);

  /// 如果 [other] 的每个元素都包含在 [this] 中，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isSupersetOf({'a', 'b'}); // true
  /// set.isSupersetOf({'a', 'b', 'c'}); // true
  /// set.isSupersetOf({'a', 'b', 'f'}); // false
  bool isSupersetOf(Set<Object> other) =>
      length >= other.length && containsAll(other);

  /// 如果 [this] 的每个元素都包含在 [other] 中并且 [other] 的至少一个元素不包含在 [this] 中，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSubsetOf({'a', 'b', 'c', 'd'}); // true
  /// set.isStrictSubsetOf({'a', 'b', 'c'}); // false
  /// set.isStrictSubsetOf({'a', 'b', 'f'}); // false
  bool isStrictSubsetOf(Set<Object> other) =>
      length < other.length && other.containsAll(this);

  /// 如果 [other] 的每个元素都包含在 [this] 中并且 [this] 的至少一个元素不包含在 [other] 中，则返回“true”。
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSupersetOf({'a', 'b'}); // true
  /// set.isStrictSupersetOf({'a', 'b', 'c'}); // false
  /// set.isStrictSupersetOf({'a', 'b', 'f'}); // false
  bool isStrictSupersetOf(Set<Object> other) =>
      length > other.length && containsAll(other);
}
