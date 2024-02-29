import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarColor extends StatelessWidget {
  final SystemUiOverlayStyle style;
  final Widget child;

  const StatusBarColor({
    super.key,
    required this.style,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: child,
    );
  }
}
