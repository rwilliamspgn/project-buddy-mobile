import 'package:flutter/cupertino.dart';

import 'nav_stack.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final NavStack<String> _navStack = NavStack<String>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);

    final _screenName = route.settings.name;
    _navStack.push(_screenName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
  }

  NavStack<String> get navStack => _navStack;
}
