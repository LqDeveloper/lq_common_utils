import 'dart:convert';
import 'dart:typed_data';

extension StringExtension on String {
  ///将字符串转为int
  int get toInt => int.parse(this);

  ///将字符串转为double
  double get toDouble => double.parse(this);

  ///将字符串转为Uri
  ///
  ///Uri的基本形式 [scheme:]scheme-specific-part[#fragment]
  ///
  ///再进一步划分可以是 [scheme:][//host:port][path][?query][#fragment]
  ///path可以有多个，每个用/连接，
  Uri? get toUri {
    try {
      return Uri.parse(this);
    } on Exception catch (_) {
      return null;
    }
  }

  /// 获取Url中路径(如 http://www.abcd.com?name=123 中的 http://www.abcd.com)
  String get removeQuery {
    final list = split("?");
    if (list.isEmpty) {
      return '';
    }
    return list.first;
  }

  ///是否是绝对路径
  bool get isAbsolute {
    try {
      return toUri?.isAbsolute ?? false;
    } on Exception catch (_) {
      return false;
    }
  }

  /// 获取Uri中的scheme(如 http)
  String get scheme {
    try {
      return toUri?.scheme ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的authority(如 http://www.abcd.com:8080 中的 www.abcd.com:8080)
  String get authority {
    try {
      return toUri?.authority ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的authority中的userInfo (如 http://user:password@host:80/path 中的 user:password)
  String get userInfo {
    try {
      return toUri?.userInfo ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的host 如果该字符串不是Url 将抛出 FormatException
  String get host {
    try {
      return toUri?.host ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的port 如果该字符串不是Url 将抛出 FormatException
  int get port {
    try {
      return toUri?.port ?? 0;
    } on Exception catch (_) {
      return 0;
    }
  }

  /// 获取Uri中的path 如果该字符串不是Url 将抛出 FormatException
  String get path {
    try {
      return toUri?.path ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的query 如果该字符串不是Url 将抛出 FormatException
  String get query {
    try {
      return toUri?.query ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的fragment 如果该字符串不是Url 将抛出 FormatException
  String get fragment {
    try {
      return toUri?.fragment ?? "";
    } on Exception catch (_) {
      return "";
    }
  }

  /// 获取Uri中的pathSegments 如果该字符串不是Url 将抛出 FormatException
  List<String> get pathSegments {
    try {
      return toUri?.pathSegments ?? [];
    } on Exception catch (_) {
      return [];
    }
  }

  /// 获取Uri中的queryParameters 如果该字符串不是Url 将抛出 FormatException
  Map<String, String> get queryParameters {
    try {
      return toUri?.queryParameters ?? {};
    } on Exception catch (_) {
      return {};
    }
  }

  /// 获取Uri中的queryParametersAll 如果该字符串不是Url 将抛出 FormatException
  Map<String, List<String>> get queryParametersAll {
    try {
      return toUri?.queryParametersAll ?? {};
    } on Exception catch (_) {
      return {};
    }
  }

  ///字符串是否符合正则表达式
  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  ///判断字符串是否为数字（int,double）
  bool get isNum => num.tryParse(this) is num;

  ///字符串中是否只包含数字
  bool get isNumericOnly => hasMatch(r'^\d+$');

  ///字符串中是否只包含字母
  bool get isAlphabetOnly => hasMatch(r'^[a-zA-Z]+$');

  ///字符串是否包含最少一个大写字母
  bool get hasCapitalLetter => hasMatch(r'[A-Z]');

  ///是否是bool值
  bool get isBool =>
      (this == 'true' || this == '1' || this == 'false' || this == '0');

  ///检验字符串是否是邮箱
  bool get isEmail => hasMatch(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

  ///检验字符串是否是手机号
  bool get isPhoneNumber => (length > 16 || length < 9)
      ? false
      : hasMatch(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  ///检验字符串是否是中文
  bool get isChinese => hasMatch(r'^[\u4e00-\u9fa5]+$');

  ///转为二进制
  List<int> get bytes => utf8.encode(this);

  ///Base64编码
  String get encodedBase64 {
    final List<int> bytes = utf8.encode(this);
    return base64Encode(bytes);
  }

  ///Base64解码
  String get decodeBase64 {
    final Uint8List bytes = base64Decode(this);
    return utf8.decode(bytes);
  }

  ///将字符串转为数组
  List? get jsonList {
    final result = json.decode(this);
    return result is List ? result : null;
  }

  ///将字符串转为Map
  Map? get jsonMap {
    final result = json.decode(this);
    return result is Map ? result : null;
  }

  /// 从提供的字符串中删除所有空格。
  String get removeWhiteSpace {
    return replaceAll(RegExp(r"\s+"), "");
  }

  ///移除字符串开头的字符串
  String withoutPrefix(Pattern prefix) =>
      startsWith(prefix) ? substring(prefix.allMatches(this).first.end) : this;

  ///移除字符串结尾的字符串
  String withoutSuffix(Pattern suffix) {
    final matches = suffix.allMatches(this);
    return (matches.isEmpty || matches.last.end != length)
        ? this
        : substring(0, matches.last.start);
  }

  ///在指定位置插入字符
  String insert(String other, int index) => (StringBuffer()
        ..write(substring(0, index))
        ..write(other)
        ..write(substring(index)))
      .toString();

  ///将字符串分为 [pattern]、[pattern] 之前的所有内容和 [pattern] 之后的所有内容。
  List<String> partition(Pattern pattern) {
    final matches = pattern.allMatches(this);
    if (matches.isEmpty) {
      return [this, '', ''];
    }
    final matchStart = matches.first.start;
    final matchEnd = matches.first.end;
    return [
      substring(0, matchStart),
      substring(matchStart, matchEnd),
      substring(matchEnd)
    ];
  }

  ///字符串反转
  String reverse() {
    final stringBuffer = StringBuffer();
    for (var i = length - 1; i >= 0; i--) {
      stringBuffer.write(this[i]);
    }
    return stringBuffer.toString();
  }

  ///返回第一个字符为大写的字符串。
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    final trimmed = trimLeft();
    final firstCharacter = trimmed[0].toUpperCase();
    return trimmed.replaceRange(0, 1, firstCharacter);
  }
}

extension NullableStringExtension on String? {
  ///判断字符串是否为null或者为空
  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;

  ///判断字符串是否为非null或者为非空
  bool get isNotNullOrEmpty => this?.trim().isNotEmpty ?? false;

  ///如果为空则返回默认值
  String getVal({String defValue = ''}) => this ?? defValue;
}
