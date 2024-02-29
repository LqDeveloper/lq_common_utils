import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LayoutInfoNotification extends Notification {
  final BoxConstraints constraints;
  final Size size;
  final int? index;

  const LayoutInfoNotification({
    required this.constraints,
    required this.size,
    this.index,
  });

  @override
  String toString() {
    return "index:$index --- constraints:$constraints --- size:$size";
  }
}

typedef LayoutChangedCallback = void Function(
  BoxConstraints constraints,
  Size size,
);

class ItemSizeInfoNotifier extends SingleChildRenderObjectWidget {
  final int? index;
  final LayoutChangedCallback? layoutChanged;

  const ItemSizeInfoNotifier({
    super.key,
    super.child,
    this.index,
    this.layoutChanged,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeChangedRenderBox(layoutChanged: (cons, size) {
      layoutChanged?.call(cons, size);
      LayoutInfoNotification(
        constraints: cons,
        size: size,
        index: index,
      ).dispatch(context);
    });
  }
}

class _SizeChangedRenderBox extends RenderProxyBox {
  final LayoutChangedCallback layoutChanged;

  _SizeChangedRenderBox({
    RenderBox? child,
    required this.layoutChanged,
  }) : super(child);

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize) {
      layoutChanged(constraints, size);
    }
    _oldSize = size;
  }
}
