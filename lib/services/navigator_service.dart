import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  NavigatorState? navigatorState() => navigatorKey.currentState;

  void navigatePush(String routeName, {Object? args}) {
    navigatorState()!.restorablePushNamed(routeName, arguments: args);
  }

  navigateRoot(String routeName, {Object? args}) {
    navigatorState()!.popUntil((route) => route.isFirst);
    navigatorState()!.pushReplacementNamed(routeName, arguments: args);
  }

  navigateTransfer(String routeName, {Object? args}) {
    navigatorState()!.restorablePopAndPushNamed(routeName, arguments: args);
  }

  void navigatePopUntil({Object? args}) {
    navigatorState()!.popUntil((route) => route.isFirst);
  }

  navigateBack({String defaultRoute: '/'}) async {
    if (navigatorState()!.canPop()) {
      navigatorState()!.pop(true);
    } else {
      navigatorState()!.pushReplacementNamed(defaultRoute);
    }
  }
}
