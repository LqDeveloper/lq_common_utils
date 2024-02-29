import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double value;

  const VSpace(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}
