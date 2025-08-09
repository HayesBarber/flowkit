import 'package:flowkit/src/navigation_extensions.dart';
import 'package:flutter/material.dart';

/// Abstract base class for a provider that manages a nested [NavigatorState] via [navKey],
/// tracking navigation depth to correctly handle iOS back-swipe gestures.
abstract class NestedNavigatorProvider extends ChangeNotifier {
  /// The [GlobalKey] associated with the nested [NavigatorState] this provider controls.
  GlobalKey<NavigatorState> navKey;

  int _layer = 0;

  /// Creates a [NestedNavigatorProvider] with the given [navKey].
  NestedNavigatorProvider({required this.navKey});

  void _incrementLayer() {
    _layer++;
    notifyListeners();
  }

  void _decrementLayer() {
    _layer--;
    notifyListeners();
  }

  /// Whether the nested navigator can pop a route.
  ///
  /// Returns `true` if there is at least one route above the first in the stack.
  bool get canPop {
    return _layer < 1;
  }

  /// Pushes a new [page] onto the nested navigator stack and increments the depth counter.
  ///
  /// Once the pushed page is popped, the depth counter is decremented automatically.
  Future<dynamic>? push(Widget page) {
    _incrementLayer();
    return navKey.push(page)?.then((value) {
      _decrementLayer();
      return value;
    });
  }

  /// Pops the top route from the nested navigator stack.
  void pop() {
    navKey.currentState?.pop();
  }

  /// Pops all routes in the nested navigator until the first route is reached.
  void popUntilFirst() {
    navKey.popUntilFirst();
  }
}
