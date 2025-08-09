import 'package:flowkit/src/flow_registry.dart';
import 'package:flowkit/src/navigation_service.dart';
import 'package:flowkit/src/nested_navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlowStarter {
  FlowStarter._();
  static final FlowStarter _instance = FlowStarter._();
  static FlowStarter get I => _instance;

  Future? start(String flowKey, [List<dynamic>? args]) {
    final def = FlowRegistry.get(flowKey);

    if (def == null) {
      throw ArgumentError('No flow registered for key: $flowKey');
    }

    return _nestedNavigator(
      providerBuilder: (navKey) => def.createProvider(navKey, args),
      childBuilder: def.buildEntry,
      slideBottom: def.slideFromBottom,
    );
  }

  Future? _nestedNavigator<T extends NestedNavigatorProvider>({
    required T Function(GlobalKey<NavigatorState>) providerBuilder,
    required Widget Function(BuildContext) childBuilder,
    bool slideBottom = true,
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
