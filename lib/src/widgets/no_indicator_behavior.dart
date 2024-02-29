import 'package:flutter/material.dart';

///去掉安卓listview的水波纹
/// ScrollConfiguration(
///     behavior: NoIndicatorBehavior(),
///     child: ...
/// ),
class NoIndicatorBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        break;
    }
    return GlowingOverscrollIndicator(
      showLeading: false,
      showTrailing: false,
      axisDirection: details.direction,
      color: Colors.transparent,
      child: child,
    );
  }
}
