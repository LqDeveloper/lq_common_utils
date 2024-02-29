import 'package:flutter/material.dart';

mixin StateContextReadyMixin<T extends StatefulWidget> on State<T> {
  bool _didRunOnContextReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didRunOnContextReady) {
      _didRunOnContextReady = true;
      final settings = ModalRoute.of(context)?.settings;
      onArgumentsReady(context, settings?.name, settings?.arguments);
    }
  }

  ///在这个方法里可以获取路由的传参，并且只会走一次
  @protected
  void onArgumentsReady(
    BuildContext context,
    String? routeName,
    Object? arguments,
  ) {}
}
