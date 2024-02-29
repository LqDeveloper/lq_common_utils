class ObjectUtils {
  ObjectUtils._();

  ///判断对象是否为空
  static bool isNull(dynamic obj) {
    return obj == null;
  }

  ///判断对象是否不为空
  static bool isNotNull(dynamic obj) {
    return obj != null;
  }

  ///判断字符串是否null或者为空字符串
  static bool isEmptyString(String? str) {
    return str == null || str.isEmpty;
  }

  /// 判断集合是否为null或者为空list
  static bool isEmptyList(Iterable? list) {
    return list == null || list.isEmpty;
  }

  /// 判断集合是否为null或者为空map
  static bool isEmptyMap(Map? map) {
    return map == null || map.isEmpty;
  }

  ///判断对象是否为null或者为空字符串，空list,空map
  static bool isEmpty(Object? object) {
    if (object == null) {
      return true;
    }
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is Iterable && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

  /// 判断字符串，list,map是否不为空
  static bool isNotEmpty(Object? object) {
    return !isEmpty(object);
  }

  /// 判断两个list是否相等
  static bool twoListIsEqual(List? listA, List? listB) {
    if (listA == listB) {
      return true;
    }
    if (listA == null || listB == null) {
      return false;
    }
    final int length = listA.length;
    if (length != listB.length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (!listA.contains(listB[i])) {
        return false;
      }
    }
    return true;
  }

  /// 获取对象的长度
  static int getLength(Object? value) {
    if (value == null) {
      return 0;
    }
    if (value is String) {
      return value.length;
    } else if (value is Iterable) {
      return value.length;
    } else if (value is Map) {
      return value.length;
    } else {
      return 0;
    }
  }
}
