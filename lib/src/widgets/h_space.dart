import 'package:flutter/material.dart';

class HSpace extends StatelessWidget {
  final double value;

  const HSpace(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value);
  }
}
