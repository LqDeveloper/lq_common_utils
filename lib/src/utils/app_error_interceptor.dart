import 'dart:ui';

import 'package:flutter/material.dart';

///错误类型
enum AppErrorType { flutter, platform }

extension ErrorDesc on AppErrorType {
  String get description {
    switch (this) {
      case AppErrorType.flutter:
        return 'Flutter 框架捕获的错误';
      case AppErrorType.platform:
        return '未被 Flutter框架 捕获的错误';
    }
  }
}

typedef AppErrorCallback = void Function(Object error, StackTrace? stack);
typedef AppErrorTypeCallback = void Function(
  AppErrorType errorType,
  Object error,
  StackTrace? stack,
);

///系统错误拦截器
class AppErrorInterceptor {
  ///Flutter 导致的错误
  static void flutterError(AppErrorCallback callback) {
    FlutterError.onError = (details) {
      //每当 Flutter 框架想要向用户显示错误时调用。
      FlutterError.presentError(details);
      callback(details.exception, details.stack);
    };
  }

  ///未被 Flutter 捕获的错误,比如MethodChannel.invokeMethod等抛出的错误
  static void platformError(AppErrorCallback callback) {
    PlatformDispatcher.instance.onError = (error, stack) {
      callback(error, stack);
      return true;
    };
  }

  ///处理所有类型的错误
  static void handleAllError(AppErrorTypeCallback callback) {
    flutterError((error, stack) {
      callback(AppErrorType.flutter, error, stack);
    });
    platformError((error, stack) {
      callback(AppErrorType.platform, error, stack);
    });
  }
}
