import 'package:flowkit/src/flow_definition.dart';

class FlowRegistry {
  static final _flows = <String, FlowDefinition>{};

  static void register(String key, FlowDefinition flow) {
    _flows[key] = flow;
  }

  static FlowDefinition? get(String key) => _flows[key];
}
