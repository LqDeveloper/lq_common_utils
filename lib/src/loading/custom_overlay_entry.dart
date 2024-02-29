import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:meta/meta.dart';

@internal
class CustomOverlayEntry extends OverlayEntry {
  @override
  CustomOverlayEntry({required super.builder});

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
