import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'custom_overlay_entry.dart';
import 'loading_utils.dart';

@internal
class CustomLoading extends StatefulWidget {
  final Widget? child;

  const CustomLoading({super.key, required this.child});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  late OverlayEntry _entry;

  @override
  void initState() {
    super.initState();
    _entry = LoadingUtils.createEntry();
  }

  @override
  void dispose() {
    super.dispose();
    LoadingUtils.disposeEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          CustomOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return const SizedBox();
              }
            },
          ),
          _entry,
        ],
      ),
    );
  }
}
