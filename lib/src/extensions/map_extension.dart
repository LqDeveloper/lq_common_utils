import 'dart:convert';

extension MapExtensions<K, V> on Map<K, V> {
  /// 将map转化为json字符串
  String get toJsonString {
    return jsonEncode(this);
  }

  /// 将map转化为json字符串换行
  String get toJsonPretty {
    return const JsonEncoder.withIndent('\t').convert(this);
  }

  ///key List
  List<K> get keyList => keys.toList();

  ///value List
  List<V> get valueList => values.toList();

  ///安全的获取map中的值
  V safeGet(K key, {required V defVal}) {
    if (containsKey(key)) {
      return this[key] ?? defVal;
    }
    return defVal;
  }

  ///返回一个新的 [Map]，其中包含键满足 [test] 的 [this] 的所有条目。
  /// var map = {'a': 1, 'bb': 2, 'ccc': 3}
  /// map.whereKey((key) => key.length > 1); // {'bb': 2, 'ccc': 3}
  Map<K, V> whereKey(bool Function(K) test) =>
      Map.fromEntries(entries.where((entry) => test(entry.key)));

  ///返回一个新的 [Map]，其中包含值满足 [test] 的 [this] 的所有条目。
  /// var map = {'a': 1, 'b': 2, 'c': 3};
  /// map.whereValue((value) => value > 1); // {'b': 2, 'c': 3}
  Map<K, V> whereValue(bool Function(V) test) =>
      Map.fromEntries(entries.where((entry) => test(entry.value)));

  ///移除Value为null 键值对
  Map<K, V> get removeNull {
    final Map<K, V> temp = {};
    for (final key in keyList) {
      if (this[key] != null) {
        temp[key] = this[key] as V;
      }
    }
    return temp;
  }
}

extension NullableMapExtension<K, V> on Map<K, V>? {
  ///判断List是否为null或者为空
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  ///判断List是否为非null或者为非空
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;

  ///如果为空则返回默认值
  Map<K, V> getVal({Map<K, V> defValue = const {}}) => this ?? defValue;
}
