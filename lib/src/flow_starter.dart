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

    final key = GlobalKey<NavigatorState>();

    final widget = ChangeNotifierProvider<NestedNavigatorProvider>(
      create: (context) => def.createProvider(key, args),
      builder: (context, _) {
        final provider = context.read<NestedNavigatorProvider>();

        return PopScope(
          canPop: provider.canPop,
          child: Navigator(
            key: key,
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: def.buildEntry,
                settings: settings,
              );
            },
          ),
        );
      },
    );

    if (def.slideFromBottom) {
      return Navigation.I.pushSlideBottom(widget);
    }

    return Navigation.I.push(widget);
  }
}
