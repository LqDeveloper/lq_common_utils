import 'package:flutter/material.dart';

typedef LocaleBuilder = Widget Function(
  BuildContext context,
  Locale? currentLocale,
);

/// 国际化管理Widget
class AppLocaleWidget extends StatefulWidget {
  final Locale? initLocale;
  final LocaleBuilder builder;

  const AppLocaleWidget({
    super.key,
    this.initLocale,
    required this.builder,
  });

  @override
  State<AppLocaleWidget> createState() => AppLocaleWidgetState();

  static AppLocaleWidgetState of(BuildContext context) {
    final state = context.findAncestorStateOfType<AppLocaleWidgetState>();
    assert(state != null, '父节点中并没有AppLocaleWidget包裹');
    return state!;
  }

  static AppLocaleWidgetState? maybeOf(BuildContext context) {
    final state = context.findAncestorStateOfType<AppLocaleWidgetState>();
    return state;
  }

  static void setupLocal(BuildContext context, Locale? locale) {
    of(context).setupLocal(locale);
  }

  static Locale? watch(BuildContext context) {
    return _AppInheritedLocale.watch(context).locale;
  }

  static Locale? read(BuildContext context) {
    return _AppInheritedLocale.read(context).locale;
  }
}

class AppLocaleWidgetState extends State<AppLocaleWidget> {
  final ValueNotifier<Locale?> localValueNotifier = ValueNotifier(null);

  Locale? get locale => localValueNotifier.value;

  @override
  void initState() {
    super.initState();
    setupLocal(widget.initLocale);
  }

  void setupLocal(Locale? locale) {
    localValueNotifier.value = locale;
  }

  @override
  void didUpdateWidget(covariant AppLocaleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initLocale != widget.initLocale) {
      setupLocal(widget.initLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
        valueListenable: localValueNotifier,
        builder: (BuildContext context, Locale? value, Widget? child) {
          return _AppInheritedLocale(
            locale: value,
            child: widget.builder(context, value),
          );
        });
  }
}

/// 管理国际化
class _AppInheritedLocale extends InheritedWidget {
  final Locale? locale;

  const _AppInheritedLocale({
    required this.locale,
    required super.child,
  });

  static _AppInheritedLocale watch(
    BuildContext context,
  ) {
    final localeWidget =
        context.dependOnInheritedWidgetOfExactType<_AppInheritedLocale>();
    assert(localeWidget != null, "父节点中未找到AppLocalInherited");
    return localeWidget!;
  }

  static _AppInheritedLocale read(
    BuildContext context,
  ) {
    final localeWidget = context
        .getElementForInheritedWidgetOfExactType<_AppInheritedLocale>()
        ?.widget;
    assert(localeWidget != null, "父节点中未找到AppLocalInherited");
    return (localeWidget! as _AppInheritedLocale);
  }

  @override
  bool updateShouldNotify(covariant _AppInheritedLocale oldWidget) =>
      locale != oldWidget.locale;
}
