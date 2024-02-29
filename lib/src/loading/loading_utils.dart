import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'custom_loading.dart';
import 'custom_overlay_entry.dart';
import 'loading_container.dart';

class LoadingUtils {
  @internal
  static final LoadingUtils instance = LoadingUtils._();

  factory LoadingUtils() {
    return instance;
  }

  LoadingUtils._();

  OverlayEntry? _entry;

  set entry(OverlayEntry value) {
    _entry = value;
  }

  WidgetBuilder? _builder;
  bool _absorbing = true;

  @internal
  static OverlayEntry createEntry() {
    final entry = CustomOverlayEntry(
      builder: (cxt) {
        if (instance._builder != null) {
          return LoadingContainer(
            absorbing: instance._absorbing,
            child: instance._builder?.call(cxt) ?? const SizedBox(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
    instance.entry = entry;
    return entry;
  }

  @internal
  static void disposeEntry() {
    dismiss();
    instance._entry = null;
  }

  ///初始化loading
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, CustomLoading(child: child));
      } else {
        return CustomLoading(child: child);
      }
    };
  }

  static void show({required WidgetBuilder builder, bool absorbing = true}) {
    if (instance._builder != null) {
      return;
    }
    instance._absorbing = absorbing;
    instance._builder = builder;
    instance._entry?.markNeedsBuild();
  }

  static void dismiss() {
    if (instance._builder == null) {
      return;
    }
    instance._builder = null;
    instance._entry?.markNeedsBuild();
  }
}
