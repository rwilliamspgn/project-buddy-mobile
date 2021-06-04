import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/pages/landing.dart';

import 'goto.dart';
import 'helper.dart';
import 'navigator_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routingData;
    if (settings.name != null) {
      final settingsName = settings.name;
      routingData = settingsName != null ? settingsName.getRoutingData : null;
    }

    List names = routingData.route.toString().split('/');
    String name = names[1];
    print(name);
    Helper.currentRouteName = name;

    switch (routingData.route) {
      case '/not-found':
        return _error404(settings);
      case '/':
        return _pageBuilder(LandingPage(), settings, guarded: false);

      default:
        return _error404(settings);
    }
  }

  static _pageBuilder(Widget page, RouteSettings settings, {bool guarded}) {
    String routeName = settings.name;
    if (guarded != null) {
      if (guarded) {
        if (Helper.globalBox.get('token') == null) {
          routeName = '/';
          page = LandingPage();
        }
      } else {
        // if (Helper.globalBox.get('token') != null) {
        //   routeName = '/dashboard';
        //   page = DashboardPage();
        // }
      }
    }

    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        if (Args.wAnimation == WAnimation.goUp) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else if (Args.wAnimation == WAnimation.goDown) {
          var begin = Offset(0.0, -1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else if (Args.wAnimation == WAnimation.goLeft) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      },
    );
  }

  static Route<dynamic> _error404(RouteSettings settings) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Page Not Found'),
          ),
          body: Center(
            child: Image.asset(Assets.assetsLogo),
          ),
        );
      },
    );
  }
}

class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;

  RoutingData({this.route, Map<String, String> queryParameters}) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);

    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
