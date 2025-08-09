import 'package:flowkit/src/nested_navigator_provider.dart';
import 'package:flutter/material.dart';

abstract class FlowDefinition {
  Widget buildEntry(BuildContext context);
  NestedNavigatorProvider createProvider(
    GlobalKey<NavigatorState> navKey, [
    List<dynamic>? args,
  ]);
  bool get slideFromBottom => false;
}
