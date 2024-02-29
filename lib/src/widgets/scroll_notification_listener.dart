import 'package:flutter/material.dart';

typedef OnStart = void Function(ScrollStartNotification start);
typedef OnUpdate = void Function(ScrollUpdateNotification update);
typedef OnEnd = void Function(ScrollEndNotification end);

class ScrollNotificationListener extends StatelessWidget {
  final OnStart? onStart;
  final OnUpdate? onUpdate;
  final OnEnd? onEnd;
  final Widget child;

  const ScrollNotificationListener({
    super.key,
    this.onStart,
    this.onUpdate,
    this.onEnd,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            onStart?.call(notification);
          } else if (notification is ScrollUpdateNotification) {
            onUpdate?.call(notification);
          } else if (notification is ScrollEndNotification) {
            onEnd?.call(notification);
          }
          return true;
        },
        child: child);
  }
}
