# flowkit

A Flutter package for managing nested navigation flows with correct back-swipe behavior on iOS.

## Why

On iOS, Flutter's default back-swipe gesture will pop the entire nested navigator stack, which is not native iOS behavior. Flowkit fixes this by tracking navigation depth inside a nested `Navigator` so that a back-swipe only pops a single route.

## Features

- Nested `Navigator` management
- Correct iOS back-swipe behavior
- Easy provider integration for flow state
- Optional slide-from-bottom presentation

## Usage

### Attach the Navigator Key

You must provide the global navigator key to your `MaterialApp` for global navigation to work. Use `Navigation.I.navigatorKey` as shown below:

```dart
import 'package:flowkit/flowkit.dart';

MaterialApp(
  navigatorKey: Navigation.I.navigatorKey,
  // other properties...
);
```

### Define a Flow

Implement a `NestedNavigatorProvider` to manage navigation inside your flow.

```dart
class CreateUserProvider extends NestedNavigatorProvider {
  CreateUserProvider({required super.navKey});
}
```

### Register and Start Flows

In your app, create a registry to start flows:

```dart
enum Flows { createUser }

class FlowRegistry {
  static Future? startFlow(Flows flow) {
    switch (flow) {
      case Flows.createUser:
        return FlowStarter.start(
          providerBuilder: (key) => CreateUserProvider(navKey: key),
          childBuilder: (context) => const CreateUserEntry(),
        );
    }
  }
}
```

### Inside a Flow

Use the provider to push and pop pages without breaking iOS swipe behavior:

```dart
provider.push(SomePage());
provider.pop();
```

## API Overview

- **FlowStarter** – Starts a new flow with its own `Navigator` and provider
- **NestedNavigatorProvider** – Base class for providers managing nested navigation depth
- **Navigation** – Singleton for global navigation actions
- **Navigation Extensions** – Helpers for `NavigatorState` and `GlobalKey<NavigatorState>`
