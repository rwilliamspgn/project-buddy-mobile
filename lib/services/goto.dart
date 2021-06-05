import 'package:project_buddy_mobile/env/config.dart';
import 'package:project_buddy_mobile/services/helper.dart';
import "package:universal_html/html.dart" as html;

import 'navigator_service.dart';
import 'routes.dart';

enum WAnimation {
  fade,
  goUp,
  goDown,
  goLeft,
}

class Goto {
  static push(String routeName,
      {WAnimation wAnimation: WAnimation.fade, bool noNavigate: false}) {
    if (noNavigate) {
      String current = routeName.split('/')[1];
      Helper.currentRouteName = current;
      if (current == 'product') {
        current += '/' + routeName.split('/')[2];
      }
      html.window.history.pushState(null, Config.appName, '/' + current);
    } else {
      Args.wAnimation = wAnimation;
      locator<NavigationService>().navigatePush(routeName);
    }
  }

  static root(String routeName,
      {WAnimation wAnimation: WAnimation.fade, bool noNavigate: false}) {
    if (noNavigate) {
      String current = routeName.split('/')[1];
      Helper.currentRouteName = current;
      while (html.window.history.length > 0) {
        html.window.history.back();
      }
      if (current == 'product') {
        current += '/' + routeName.split('/')[2];
      }
      html.window.history.pushState(null, Config.appName, '/' + current);
    } else {
      Args.wAnimation = wAnimation;
      locator<NavigationService>().navigateRoot(routeName);
    }
  }

  static transfer(String routeName,
      {WAnimation wAnimation: WAnimation.fade, bool noNavigate: false}) {
    if (noNavigate) {
      String current = routeName.split('/')[1];
      Helper.currentRouteName = current;
      if (current == 'product') {
        current += '/' + routeName.split('/')[2];
      }
      html.window.history.replaceState(null, Config.appName, '/' + current);
    } else {
      Args.wAnimation = wAnimation;
      locator<NavigationService>().navigateTransfer(routeName);
    }
  }

  static popUntil({WAnimation wAnimation: WAnimation.fade}) {
    Args.wAnimation = wAnimation;
    locator<NavigationService>().navigatePopUntil();
  }

  static back(
      {WAnimation wAnimation: WAnimation.fade,
      String defaultRoute: '/'}) async {
    Args.wAnimation = wAnimation;
    locator<NavigationService>().navigateBack(defaultRoute: defaultRoute);
  }
}

class Args {
  static WAnimation wAnimation = WAnimation.fade;
}
