import 'package:flowkit/src/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Extension methods for [GlobalKey] of type [NavigatorState] to facilitate common navigation actions.
extension NavKeyExtension on GlobalKey<NavigatorState> {
  /// Pops all routes until the first route in the navigation stack is reached.
  void popUntilFirst() {
    return currentState?.popUntil((route) => route.isFirst);
  }

  /// Pushes a new [page] onto the navigation stack.
  Future<dynamic>? push(Widget page) {
    return currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  /// Pushes a new [page] wrapped with the given [provider] onto the navigation stack.
  ///
  /// This allows injecting a [ChangeNotifier] instance into the widget tree of the new page.
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

/// Extension methods for [NavigatorState] to simplify widget navigation.
extension Nav on NavigatorState {
  /// Pushes the given [page] widget onto the navigation stack.
  Future<dynamic>? pushWidget(Widget page) {
    return push(MaterialPageRoute(builder: (_) => page));
  }

  /// Pushes the given [page] widget wrapped with the given [provider] onto the navigation stack.
  ///
  /// If [replace] is true, replaces the current route instead of pushing a new one.
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
