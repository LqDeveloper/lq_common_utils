import 'package:flutter/material.dart';

typedef ShouldRebuildCallback = bool Function(BuildContext context);

class ShouldRebuildWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final ShouldRebuildCallback? shouldRebuild;

  const ShouldRebuildWidget(
      {super.key, required this.builder, this.shouldRebuild});

  @override
  State<ShouldRebuildWidget> createState() => _ShouldRebuildState();
}

class _ShouldRebuildState extends State<ShouldRebuildWidget> {
  Widget? _oldWidget;

  @override
  Widget build(BuildContext context) {
    if (_oldWidget == null) {
      _oldWidget = widget.builder(context);
      return _oldWidget!;
    }
    final shouldRebuild = (widget.shouldRebuild?.call(context) ?? true);
    if (shouldRebuild) {
      _oldWidget = widget.builder(context);
    }
    return _oldWidget!;
  }
}
