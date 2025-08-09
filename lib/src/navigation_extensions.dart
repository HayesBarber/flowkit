import 'package:flowkit/src/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension NavKeyExtension on GlobalKey<NavigatorState> {
  void popUntilFirst() {
    return currentState?.popUntil((route) => route.isFirst);
  }

  Future<dynamic>? push(Widget page, {bool replace = false}) {
    return currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic>? pushWithProvider<T extends ChangeNotifier>(
    Widget page,
    T provider,
  ) {
    return currentState?.push(
      MaterialPageRoute(
        builder: (_) =>
            ChangeNotifierProvider.value(value: provider, child: page),
      ),
    );
  }
}

extension Nav on NavigatorState {
  Future<dynamic>? pushWidget(Widget page) {
    return push(MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic>? pushWithProvider<T extends ChangeNotifier>(
    Widget page,
    T provider, {
    bool replace = false,
  }) {
    return Navigation.I.push(
      ChangeNotifierProvider.value(value: provider, child: page),
      replace: replace,
    );
  }
}
