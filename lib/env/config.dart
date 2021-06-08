import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/env/env.dart';

class Config {
  static String appName = 'Project Buddy';

  static String baseApiUrl = '${Env.host}:${Env.port}/api';

  static Color primaryColor = Color(0xFF4BB648);
}
