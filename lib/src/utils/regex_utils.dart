/// 正则工具类
class RegexUtils {
  RegexUtils._();

  /// 邮箱正则字符串
  static const String regexEmail =
      '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';

  /// url正则字符串
  static const String regexUrl = '[a-zA-Z]+://[^\\s]*';

  /// 中文正则字符串
  static const String regexZh = '[\\u4e00-\\u9fa5]';

  /// ip4则字符串
  static const String regexIp =
      '((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)';

  /// 字符串是否是邮箱
  static bool isEmail(String? input) {
    return matches(regexEmail, input);
  }

  /// 字符串是否Url
  static bool isURL(String? input) {
    return matches(regexUrl, input);
  }

  /// 是否是中文
  static bool isZh(String input) {
    return '〇' == input || matches(regexZh, input);
  }

  /// 是否是合法的ip4
  static bool isIP(String input) {
    return matches(regexIp, input);
  }

  ///调用正则判断
  static bool matches(String regex, String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return RegExp(regex).hasMatch(input);
  }
}
