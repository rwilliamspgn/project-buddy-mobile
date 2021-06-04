import 'dart:convert';

import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Helper {
  static Box globalBox = Hive.box('Global');
  static Box routeBox = Hive.box('Route');
  static Box formBox = Hive.box('Form');
  static Box tableBox = Hive.box('Table');

  static set token(String token) {
    globalBox.put('token', token);
  }

  static String get token {
    return globalBox.get('token');
  }

  static set user(Map user) {
    globalBox.put('user', user);
  }

  static Map get user {
    return globalBox.get('user');
  }

  static set currentRouteName(String routeName) {
    routeBox.put('current', routeName);
  }

  static String get currentRouteName {
    return routeBox.get('current', defaultValue: '');
  }

  static showSuccess(BuildContext context, {String title: 'Success!', String subTitle: 'Process went well.'}) {
    AchievementView(
      context,
      title: title,
      subTitle: subTitle,
      color: Colors.green,
      listener: (status) {
        print(status);
        //AchievementState.opening
        //AchievementState.open
        //AchievementState.closing
        //AchievementState.closed
      },
    )..show();
  }

  static saveForm({@required String formKey, @required Map<String, dynamic> form}) {
    formBox.put(formKey, form);
  }

  static Map<String, dynamic> fillForm({@required String formKey, @required Map fields}) {
    Map<String, dynamic> form = {};

    Map formBox = Helper.formBox.get(formKey, defaultValue: {});
    fields.forEach((key, value) {
      form[key] = formBox[key] ?? value;
    });

    return form;
  }

  static double setWidth({@required BuildContext context, double maxWidth}) {
    Size size = MediaQuery.of(context).size;
    double _width = maxWidth ?? size.width;

    if (size.width < _width) {
      _width = size.width;
    }
    _width -= 16.0;
    return _width;
  }

  static String money(double number, {String symbol: '\$', bool compact: false, int decimalDigit: 2}) {
    var _formattedNumber = NumberFormat.compactCurrency(decimalDigits: decimalDigit, symbol: symbol).format(number);
    return _formattedNumber;
  }

  static int layoutAnimationDuration = 50;
  static double drawerDesktopMaxWidth = 300.0;
  static double drawerDesktopMinWidth = 60.0;
  static double drawerMobileMaxWidth = 300.0;
  static double drawerMobileMinWidth = 0.0;

  static void toggleDrawer() {
    bool open = isDrawerOpen();
    globalBox.put('drawerOpen', !open);
  }

  static bool isDrawerOpen() => globalBox.get('drawerOpen', defaultValue: true);

  static bool isDesktop = false;
  static bool isTablet = false;
  static bool isWatch = false;
  static bool isPhone = false;

  static setSizing({@required SizingInformation sizingInformation}) {
    isDesktop = false;
    isTablet = false;
    isWatch = false;
    isPhone = false;
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      isDesktop = true;
      globalBox.put('screenSize', 'desktop');
    } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      isTablet = true;
      globalBox.put('screenSize', 'tablet');
    } else if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
      isWatch = true;
      globalBox.put('screenSize', 'watch');
    } else {
      isPhone = true;
      globalBox.put('screenSize', 'phone');
    }
  }

  static Future<String> selectImage({ImageSource source}) async {
    source = source ?? ImageSource.gallery;

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    var uploadedImage = await pickedFile.readAsBytes();
    String imageFileBase64 = base64Encode(uploadedImage);
    return imageFileBase64;
  }

  static String getAvatarURL({bool thumbnail: true}) {
    String url;
    if (thumbnail) {
      url = user['avatar_thumbnail'];
    } else {
      url = user['avatar_original'];
    }
    if (url != null) {
      url += '?timestamp=' + user['updated_at'].toString();
    }
    return url;
  }

  static String colorToHex(Color color) {
    return color.value.toRadixString(16).substring(2);
  }
}
