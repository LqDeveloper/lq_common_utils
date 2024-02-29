import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

@internal
class LoadingContainer extends StatelessWidget {
  final bool absorbing;
  final Widget child;

  const LoadingContainer({
    super.key,
    this.absorbing = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: SafeArea(
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
