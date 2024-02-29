import 'package:flutter/material.dart';

mixin StateRouteAnimationMixin<T extends StatefulWidget> on State<T> {
  bool _didContextReady = false;
  ModalRoute? _modalRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didContextReady) {
      _didContextReady = true;
      _modalRoute = ModalRoute.of(context);
      _modalRoute?.animation?.addStatusListener(handlerAnimationStatus);
    }
  }

  @protected
  void handlerAnimationStatus(AnimationStatus status) {}

  @override
  void dispose() {
    _modalRoute?.animation?.removeStatusListener(handlerAnimationStatus);
    super.dispose();
  }
}
