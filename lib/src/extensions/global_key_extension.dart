import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  ///获取RenderBox
  RenderBox? get renderBox {
    final RenderObject? renderObject = currentContext?.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      return renderObject;
    }
    return null;
  }

  ///获取Widget在屏幕中的位置
  Offset? get location {
    return renderBox?.localToGlobal(Offset.zero);
  }

  ///获取Widget的大小
  Size? get size {
    return renderBox?.paintBounds.size;
  }
}
