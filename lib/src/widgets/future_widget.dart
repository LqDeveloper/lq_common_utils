import 'package:flutter/material.dart';

typedef FutureLoading = Widget Function(BuildContext context);

typedef FutureSuccess<T> = Widget Function(BuildContext context, T? data);

typedef FutureError = Widget Function(BuildContext context, Object? error);

class FutureWidget<T> extends StatelessWidget {
  final T? initialData;
  final Future<T>? future;
  final FutureLoading? loading;
  final FutureSuccess<T> success;
  final FutureError? error;

  const FutureWidget({
    super.key,
    this.initialData,
    this.future,
    required this.success,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        initialData: initialData,
        future: future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return error?.call(context, snapshot.error) ?? const SizedBox();
            } else {
              return success(context, snapshot.data);
            }
          } else {
            return loading?.call(context) ?? const SizedBox();
          }
        });
  }
}
