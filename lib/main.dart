import 'dart:async';

// import 'package:bot_toast/bot_toast.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_buddy_mobile/services/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wakelock/wakelock.dart';

import 'env/config.dart';
import 'services/NavStack/custom_route_observer.dart';
import 'services/navigator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Hive.initFlutter();
  await Hive.openBox('Global',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 20);
  await Hive.openBox('Route',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 20);
  await Hive.openBox('Form',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 10);
  await Hive.openBox('Table',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 10);

  setPathUrlStrategy();

  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stack) {
    print('Error: ' + error.toString());
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      Wakelock.enable();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config.appName,
      theme: ThemeData(
        primaryColor: Config.primaryColor,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white12,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:
            GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),

      builder: EasyLoading.init(builder: BotToastInit()),
      navigatorObservers: [
        BotToastNavigatorObserver(),
        CustomRouteObserver(),
      ],
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
