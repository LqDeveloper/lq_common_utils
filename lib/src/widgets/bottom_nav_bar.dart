import 'dart:async';

import 'package:flutter/material.dart';

class BottomNavUtils {
  BottomNavUtils._();

  static final BottomNavController _controller = BottomNavController();

  static BottomNavController get controller => _controller;

  static void jumpTo(int index, {Object? arguments}) {
    _controller.jumpTo(index);
  }
}

class BottomNavController {
  BottomNavBarState? _state;

  void jumpTo(int index) {
    _state?._jumpToIndex(index);
  }

  void _dispose() {
    _state = null;
  }
}

typedef BottomNavItemBuilder = Widget Function(
    BuildContext context, int index, bool isSelected);
typedef BottomNavIndexChanged = void Function(int from, int to);
typedef TapInterceptor = FutureOr<bool> Function(int from, int to);

class BottomNavBar extends StatefulWidget {
  final BottomNavController? controller;
  final int initialIndex;
  final List<Widget> pages;
  final List<String> itemLabels;
  final BottomNavItemBuilder itemBuilder;
  final BottomNavIndexChanged? onPageChanged;
  final BottomNavigationBarThemeData? data;
  final TapInterceptor? tapInterceptor;

  const BottomNavBar({
    super.key,
    this.controller,
    this.initialIndex = 0,
    this.onPageChanged,
    this.data,
    this.tapInterceptor,
    required this.pages,
    required this.itemLabels,
    required this.itemBuilder,
  })  : assert(pages.length == itemLabels.length,
            'The length of items is inconsistent with the length of pages'),
        assert(initialIndex >= 0 && initialIndex < pages.length,
            'initialIndex setting is illegal');

  static BottomNavBarState? maybeOf(BuildContext context) {
    final BottomNavBarState? state =
        context.findAncestorStateOfType<BottomNavBarState>();
    return state;
  }

  static BottomNavBarState of(BuildContext context) {
    final BottomNavBarState? state = maybeOf(context);
    assert(state != null, 'can not find BottomNavBarState');
    return state!;
  }

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    widget.controller?._state = this;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _currentIndex = widget.initialIndex;
      _jumpToIndex(_currentIndex);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._dispose();
      widget.controller?._state = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: widget.data,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.pages.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => widget.pages[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: List.generate(widget.itemLabels.length, (index) {
            final label = widget.itemLabels[index];
            return BottomNavigationBarItem(
              label: label,
              icon: widget.itemBuilder(context, index, _currentIndex == index),
            );
          }),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            _jumpToIndex(index);
          },
        ),
      ),
    );
  }

  Future<void> _jumpToIndex(int index) async {
    if (index < 0 || index >= widget.pages.length) {
      return;
    }
    if (_currentIndex != index) {
      final from = _currentIndex;
      final shouldJump =
          (await widget.tapInterceptor?.call(from, index)) ?? true;
      if (!shouldJump) {
        return;
      }
      setState(() {
        _currentIndex = index;
      });
      _pageController?.jumpToPage(index);
      widget.onPageChanged?.call(from, index);
    }
  }
}
