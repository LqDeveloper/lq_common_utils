import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ScreenInfoUtils {
  ///获取FlutterView
  static FlutterView? getFlutterView(BuildContext context) =>
      View.maybeOf(context);

  ///屏幕尺寸
  static Size screenSize(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).size;
    }
    return Size.zero;
  }

  ///屏幕宽度
  static double width(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).size.width;
    }
    return 0;
  }

  ///屏幕高度
  static double height(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).size.height;
    }
    return 0;
  }

  ///屏幕Scale
  static double scale(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).devicePixelRatio;
    }
    return 0;
  }

  ///屏幕textScaleFactor
  static TextScaler? textScaler(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).textScaler;
    }
    return null;
  }

  ///AppBar的高度
  static double get appBarHeight => kToolbarHeight;

  ///BottomNavigationBar的高度
  static double get bottomNavHeight => kBottomNavigationBarHeight;

  ///AppBar的高度加上安全区域的高度
  static double navigationBarHeight(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).padding.top + kToolbarHeight;
    }
    return kToolbarHeight;
  }

  ///头部安全区域的高度
  static double topSafeHeight(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).padding.top;
    }
    return 0;
  }

  ///底部安全区域的高度
  static double bottomSafeHeight(BuildContext context) {
    final view = getFlutterView(context);
    if (view != null) {
      return MediaQueryData.fromView(view).padding.bottom;
    }
    return 0;
  }
}
