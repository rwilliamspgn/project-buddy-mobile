import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/pages/auth/forgot_password.dart';
import 'package:project_buddy_mobile/pages/auth/login.dart';
import 'package:project_buddy_mobile/pages/auth/new_password.dart';
import 'package:project_buddy_mobile/pages/auth/register.dart';
import 'package:project_buddy_mobile/pages/auth/token_input.dart';
import 'package:project_buddy_mobile/pages/landing.dart';
import 'package:project_buddy_mobile/pages/main/contractor/my_schedules.dart';
import 'package:project_buddy_mobile/pages/main/settings.dart';
import 'package:project_buddy_mobile/pages/main/settings/change_password.dart';
import 'package:project_buddy_mobile/pages/main/settings/profile.dart';
import 'package:project_buddy_mobile/pages/main/settings/terms_and_conditions.dart';

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
    if (names.length >= 3) {
      Helper.routeExtension = names[2];
    }

    switch (routingData.route) {
      case '/not-found':
        return _error404(settings);
      case '/':
        return _pageBuilder(LandingPage(), settings, guarded: false);

      case '/login/client':
        return _pageBuilder(LoginPage(), settings, guarded: false);
      case '/login/contractor':
        return _pageBuilder(LoginPage(), settings, guarded: false);
      case '/login/buddy':
        return _pageBuilder(LoginPage(), settings, guarded: false);

      case '/register/client':
        return _pageBuilder(RegisterPage(), settings, guarded: false);
      case '/register/contractor':
        return _pageBuilder(RegisterPage(), settings, guarded: false);
      case '/register/buddy':
        return _pageBuilder(RegisterPage(), settings, guarded: false);

      case '/forgot-password':
        return _pageBuilder(ForgotPasswordPage(), settings, guarded: false);

      case '/token-input':
        return _pageBuilder(TokenInputPage(), settings, guarded: false);
      case '/set-new-password':
        return _pageBuilder(NewPasswordPage(), settings, guarded: false);

      case '/my-schedules':
        return _pageBuilder(MySchedulesPage(), settings, guarded: true);

      case '/settings':
        return _pageBuilder(SettingPage(), settings, guarded: true);
      case '/profile':
        return _pageBuilder(ProfilePage(), settings, guarded: true);
      case '/change-password':
        return _pageBuilder(ChangePasswordPage(), settings, guarded: true);
      case '/terms-and-conditions':
        return _pageBuilder(TermsAndConditionsPage(), settings, guarded: true);

      default:
        return _error404(settings);
    }
  }

  static _pageBuilder(Widget page, RouteSettings settings, {bool? guarded}) {
    String routeName = settings.name!;
    if (guarded != null) {
      if (guarded) {
        if (Helper.token.length == 0) {
          routeName = '/';
          page = LandingPage();
        }
      } else {
        if (Helper.role == 'client') {
          // TODO: update
          routeName = '/my-schedule';
          page = MySchedulesPage();
        } else if (Helper.role == 'contractor') {
          routeName = '/my-schedule';
          page = MySchedulesPage();
        } else if (Helper.role == 'buddy') {
          // TODO: update
          routeName = '/my-schedule';
          page = MySchedulesPage();
        }
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

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else if (Args.wAnimation == WAnimation.goDown) {
          var begin = Offset(0.0, -1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else if (Args.wAnimation == WAnimation.goLeft) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
  final String? route;
  final Map<String, String>? _queryParameters;

  RoutingData({this.route, required Map<String, String> queryParameters})
      : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters![key];
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
