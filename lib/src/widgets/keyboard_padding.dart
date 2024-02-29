import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

typedef KeyboardBuilder = Widget Function(
    BuildContext context, EdgeInsets padding);
typedef KeyboardCallback = void Function(EdgeInsets padding);

///使用时，必须将所在的Scaffold的resizeToAvoidBottomInset设置成false
class KeyboardPadding extends StatefulWidget {
  final KeyboardCallback? callback;
  final KeyboardBuilder builder;

  const KeyboardPadding({super.key, this.callback, required this.builder});

  @override
  State<KeyboardPadding> createState() => _KeyboardPaddingState();
}

class _KeyboardPaddingState extends State<KeyboardPadding>
    with WidgetsBindingObserver {
  EdgeInsets _padding = EdgeInsets.zero;
  bool _hasInit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInit) {
      _padding = context.windowPadding;
      _hasInit = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (context.mounted) {
      setState(() {
        _padding = context.windowPadding;
      });
    }
    widget.callback?.call(_padding);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _padding);
  }
}
