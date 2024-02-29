import 'dart:developer';

import 'package:flutter/foundation.dart';

enum LogLevel {
  debug(0),
  warning(1),
  error(2),
  off(3);

  final int val;

  const LogLevel(this.val);
}

class LogUtils {
  LogUtils._();

  static String _name = 'LogUtils';
  static LogLevel _level = LogLevel.debug;

  static void init({
    String name = 'LogUtils',
    int maxLength = 500,
    LogLevel level = LogLevel.debug,
  }) {
    _name = name;
    _level = level;
  }

  static void setLevel(LogLevel level) {
    _level = level;
  }

  ///打印debug日志
  static void d(Object? message,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    _printLog(tag, LogLevel.debug, message, error, stackTrace);
  }

  ///打印warning警告日志
  static void w(Object? message,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    _printLog(tag, LogLevel.warning, message, error, stackTrace);
  }

  ///打印error日志
  static void e(Object? message,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    _printLog(tag, LogLevel.error, message, error, stackTrace);
  }

  static void _printLog(String? tag, LogLevel level, Object? message,
      Object? error, StackTrace? stackTrace) {
    if (!kDebugMode) {
      return;
    }
    if (_level.val <= level.val) {
      final String da = message?.toString() ?? 'null';
      final str = '\n$da\n';
      log(str, error: error, stackTrace: stackTrace, name: _name);
    }
  }
}
