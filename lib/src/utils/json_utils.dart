import 'dart:convert';

/// Json 工具类
class JsonUtils {
  JsonUtils._();

  /// 将对象转为Json字符串
  static String? encodeObj(dynamic value) {
    return value == null ? null : json.encode(value);
  }

  /// 将Json字符串转为对象
  static T? getObj<T>(String? source, T Function(Map v) f) {
    if (source == null || source.isEmpty) {
      return null;
    }
    try {
      final Map map = json.decode(source);
      return f(map);
    } on Exception catch (_) {}
    return null;
  }

  /// 将listJSON字符串转为对象list
  static List<T>? getObjList<T>(String? source, T Function(Map v) f) {
    if (source == null || source.isEmpty) {
      return null;
    }
    try {
      final List list = json.decode(source);
      return list.map((value) {
        if (value is String) {
          value = json.decode(value);
        }
        return f(value);
      }).toList();
    } on Exception catch (_) {}
    return null;
  }
}
