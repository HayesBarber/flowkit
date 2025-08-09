import 'package:flowkit/src/navigation_service.dart';
import 'package:flowkit/src/nested_navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Entry point for launching a nested navigation flow with its own [Navigator] and provider.
class FlowStarter {
  /// Starts a new navigation flow by creating a nested [Navigator] managed by a [NestedNavigatorProvider].
  ///
  /// The [providerBuilder] is called with a [GlobalKey<NavigatorState>] to create the provider instance.
  /// The [childBuilder] is used to build the initial page in the flow.
  ///
  /// If [slideBottom] is true, the flow is presented with a slide-from-bottom transition.
  ///
  /// Returns a [Future] that completes when the pushed flow is popped.
  static Future? start<T extends NestedNavigatorProvider>({
    required T Function(GlobalKey<NavigatorState>) providerBuilder,
    required Widget Function(BuildContext) childBuilder,
    bool slideBottom = false,
  }) {
    final key = GlobalKey<NavigatorState>();

    final widget = ChangeNotifierProvider<T>(
      create: (context) => providerBuilder(key),
      builder: (context, _) {
        final provider = Provider.of<T>(context);

        return PopScope(
          canPop: provider.canPop,
          child: Navigator(
            key: key,
            onGenerateRoute: (settings) =>
                MaterialPageRoute(builder: childBuilder, settings: settings),
          ),
        );
      },
    );

    return slideBottom
        ? Navigation.I.pushSlideBottom(widget)
        : Navigation.I.push(widget);
  }
}
