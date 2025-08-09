import 'package:flowkit/src/navigation_extensions.dart';
import 'package:flowkit/src/slide_bottom_route.dart';
import 'package:flutter/material.dart';

class Navigation {
  Navigation._();
  static final Navigation _instance = Navigation._();
  static Navigation get I => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? push(Widget page, {bool replace = false}) {
    if (replace) {
      return pushReplacement(page);
    }
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<dynamic>? pushReplacement(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<dynamic>? pushAndRemoveAll(Widget page) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

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

  Future<dynamic>? pushSlideBottom(Widget page) {
    return navigatorKey.currentState?.push(SlideBottomRoute(page: page));
  }

  void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }
}
