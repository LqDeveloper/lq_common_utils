extension IntExtension on int {
  /// 返回一个从“0”到但不包括 [this] 的可迭代对象。
  /// 5.range; // (0, 1, 2, 3, 4)
  Iterable<int> get range => Iterable<int>.generate(this);

  /// 返回years的Duration
  Duration get days => Duration(days: this);

  /// 返回days的Duration
  Duration get hours => Duration(hours: this);

  /// 返回minutes的Duration
  Duration get minutes => Duration(minutes: this);

  /// 返回seconds的Duration
  Duration get seconds => Duration(seconds: this);

  /// 返回milliseconds的Duration
  Duration get milliseconds => Duration(milliseconds: this);

  /// 返回microseconds的Duration
  Duration get microseconds => Duration(microseconds: this);
}
