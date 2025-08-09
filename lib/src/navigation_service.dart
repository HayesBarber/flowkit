import 'package:flowkit/src/navigation_extensions.dart';
import 'package:flowkit/src/slide_bottom_route.dart';
import 'package:flutter/material.dart';

/// A singleton navigation handler that exposes helper methods for navigating
/// throughout the application without directly relying on [BuildContext].
class Navigation {
  Navigation._();
  static final Navigation _instance = Navigation._();

  /// Accessor for the singleton [Navigation] instance.
  static Navigation get I => _instance;

  /// The [GlobalKey] associated with the application's [NavigatorState].
  /// This is required for performing navigation without a [BuildContext].
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Pushes the given [page] onto the navigation stack.
  ///
  /// If [replace] is true, replaces the current route with the new [page].
  Future<dynamic>? push(Widget page, {bool replace = false}) {
    if (replace) {
      return pushReplacement(page);
    }
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Replaces the current route with the given [page] on the navigation stack.
  Future<dynamic>? pushReplacement(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pushes the given [page] and removes all existing routes from the stack.
  Future<dynamic>? pushAndRemoveAll(Widget page) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pushes the given [page] wrapped with the provided [ChangeNotifier] onto the navigation stack.
  ///
  /// If [replace] is true, replaces the current route instead of pushing.
  Future<dynamic>? pushWithProvider<T extends ChangeNotifier>(
    Widget page,
    T provider, {
    bool replace = false,
  }) {
    return navigatorKey.currentState?.pushWithProvider(
      page,
      provider,
      replace: replace,
    );
  }

  /// Pushes the given [page] using a custom slide-from-bottom transition.
  Future<dynamic>? pushSlideBottom(Widget page) {
    return navigatorKey.currentState?.push(SlideBottomRoute(page: page));
  }

  /// Pops the current route off the navigation stack, optionally returning a [result].
  void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }
}
