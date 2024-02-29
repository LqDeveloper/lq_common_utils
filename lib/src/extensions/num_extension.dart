extension NumExtenson on num {
  ///是否位于某个区县内
  bool isInRange(num min, num max) => this >= min && this <= max;
}
