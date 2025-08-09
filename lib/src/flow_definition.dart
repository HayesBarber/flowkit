import 'package:flutter/material.dart';

abstract class FlowDefinition {
  Widget buildEntry(BuildContext context);
  ChangeNotifier createProvider(GlobalKey<NavigatorState> navKey);
  bool slideFromBottom = false;
}
