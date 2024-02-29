import 'package:flutter/material.dart';

abstract class ColorUtils {
  ///获取颜色的透明度
  static int alpha(String code) {
    try {
      final int length = code.length;
      if (length < 8) {
        return 255;
      }
      return int.parse(code.substring(0, 2), radix: 16);
    } on Exception catch (_) {
      return 0;
    }
  }

  ///获取颜色的R
  static int red(String code) {
    try {
      final int length = code.length;
      if (length == 3) {
        var s = code.substring(0, 1);
        s += s;
        return int.parse(s, radix: 16);
      } else if (length == 6) {
        return int.parse(code.substring(0, 2), radix: 16);
      } else {
        return int.parse(code.substring(2, 4), radix: 16);
      }
    } on Exception catch (_) {
      return 0;
    }
  }

  ///获取颜色的G
  static int green(String code) {
    try {
      final int length = code.length;
      if (length == 3) {
        var s = code.substring(1, 2);
        s += s;
        return int.parse(s, radix: 16);
      } else if (length == 6) {
        return int.parse(code.substring(2, 4), radix: 16);
      } else {
        return int.parse(code.substring(4, 6), radix: 16);
      }
    } on Exception catch (_) {
      return 0;
    }
  }

  ///获取颜色的B
  static int blue(String code) {
    try {
      final int length = code.length;
      if (length == 3) {
        var s = code.substring(2, 3);
        s += s;
        return int.parse(s, radix: 16);
      } else if (length == 6) {
        return int.parse(code.substring(4, 6), radix: 16);
      } else {
        return int.parse(code.substring(6), radix: 16);
      }
    } on Exception catch (_) {
      return 0;
    }
  }

  ///字符串转Color
  static Color toColor(String? color, {Color defaultColor = Colors.black}) {
    if (color == null || color.isEmpty) {
      return defaultColor;
    }
    if (!color.contains("#")) {
      return defaultColor;
    }
    String hexColor = color.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "0xff$hexColor";
      final Color color = Color(int.parse(hexColor));
      return color;
    }
    if (hexColor.length == 8) {
      final Color color = Color(int.parse("0x$hexColor"));
      return color;
    }
    return defaultColor;
  }

  ///Color转字符串
  static String colorString(Color color) {
    final int value = color.value;
    final String radixString = value.toRadixString(16);
    final String colorString = radixString.padLeft(8, '0').toUpperCase();
    return "#$colorString";
  }
}
