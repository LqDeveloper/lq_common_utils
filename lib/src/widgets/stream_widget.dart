import 'package:flutter/material.dart';

typedef StreamData<T> = Widget Function(
    BuildContext context, ConnectionState state, T? data);
typedef StreamError = Widget Function(BuildContext context, Object? error);

class StreamWidget<T> extends StatelessWidget {
  final T? initialData;
  final Stream<T>? stream;
  final StreamData data;
  final StreamError? error;

  const StreamWidget({
    super.key,
    this.initialData,
    required this.stream,
    required this.data,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: initialData,
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasError) {
            return error?.call(context, snapshot.error) ?? const SizedBox();
          } else {
            return data(context, snapshot.connectionState, snapshot.data);
          }
        });
  }
}
