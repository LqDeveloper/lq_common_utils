import 'dart:convert';

extension ListExtensions<T> on List<T> {
  /// 将list转化为json字符串
  String get toJsonString {
    return jsonEncode(this);
  }

  /// 将list转化为json字符串，换行
  String get toJsonPretty {
    return const JsonEncoder.withIndent('\t').convert(this);
  }

  ///安全的获取list中的值
  T safeGet(int index, {required T defVal}) {
    if (index < 0 || index > length) {
      return defVal;
    }
    return this[index];
  }

  ///List map操作
  List<A> mapList<A>(A Function(T e) toElement) => map(toElement).toList();

  ///返回一个新List对象
  List<T> copyList() {
    return List<T>.of(this);
  }

  ///排序
  /// var list = [-12, 3, 10];
  /// list.sortBy((e) => e.toString().length); // [3, 10, -12].
  void sortBy(Comparable<dynamic> Function(T) sortKey) {
    final sortKeyCache = <T, Comparable<dynamic>>{};
    sort((a, b) => _sortKeyCompare(a, b, sortKey, sortKeyCache));
  }

  ///返回一个排序后的新List对象
  List<T> sortedCopyBy(Comparable<dynamic> Function(T) sortKey) {
    return List<T>.of(this)..sortBy(sortKey);
  }

  ///安全的删除最后一个
  T? safeRemoveLast() {
    if (isEmpty) {
      return null;
    }
    return removeLast();
  }
}

extension NullableListExtension<T> on List<T>? {
  ///判断List是否为null或者为空
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  ///判断List是否为非null或者为非空
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;

  ///如果为空则返回默认值
  List<T> getVal({List<T> defValue = const []}) => this ?? defValue;
}

int _sortKeyCompare<T>(
  T a,
  T b,
  Comparable<Object?> Function(T) sortKey,
  Map<T, Comparable<Object?>> sortKeyCache,
) {
  final keyA = sortKeyCache.putIfAbsent(a, () => sortKey(a));
  final keyB = sortKeyCache.putIfAbsent(b, () => sortKey(b));
  return keyA.compareTo(keyB);
}
