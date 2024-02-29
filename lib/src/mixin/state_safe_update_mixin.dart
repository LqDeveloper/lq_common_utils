import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin StateSafeUpdateMixin<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(fn);
      });
    } else {
      setState(fn);
    }
  }
}
