import 'package:flowkit/src/navigation_extensions.dart';
import 'package:flutter/material.dart';

abstract class NestedNavigatorProvider extends ChangeNotifier {
  GlobalKey<NavigatorState> navKey;
  int _layer = 0;

  NestedNavigatorProvider({required this.navKey});

  void _incrementLayer() {
    _layer++;
    notifyListeners();
  }

  void _decrementLayer() {
    _layer--;
    notifyListeners();
  }

  bool get canPop {
    return _layer < 1;
  }

  Future<dynamic>? push(Widget page) {
    _incrementLayer();
    return navKey.push(page)?.then((value) {
      _decrementLayer();
      return value;
    });
  }

  void pop() {
    navKey.currentState?.pop();
  }

  void popUntilFirst() {
    navKey.popUntilFirst();
  }
}
