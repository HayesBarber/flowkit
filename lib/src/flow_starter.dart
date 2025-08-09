import 'package:flowkit/src/navigation_service.dart';
import 'package:flowkit/src/nested_navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlowStarter {
  FlowStarter._();
  static final FlowStarter _instance = FlowStarter._();
  static FlowStarter get I => _instance;

  Future? _nestedNavigator<T extends NestedNavigatorProvider>({
    required T Function(
      BuildContext context,
      GlobalKey<NavigatorState> navigatorKey,
    )
    providerBuilder,
    required Widget Function(BuildContext context) childBuilder,
    bool slideBottom = true,
  }) {
    final key = GlobalKey<NavigatorState>();

    final widget = ChangeNotifierProvider<T>(
      create: (context) => providerBuilder(context, key),
      builder: (context, _) {
        final provider = Provider.of<T>(context);

        return PopScope(
          canPop: provider.canPop,
          child: Navigator(
            key: key,
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: childBuilder,
                settings: settings,
              );
            },
          ),
        );
      },
    );

    if (slideBottom) {
      return Navigation.I.pushSlideBottom(widget);
    }

    return Navigation.I.push(widget);
  }
}
