import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/env/config.dart';

import '../goto.dart';
import '../helper.dart';

class APIResponse {
  final String message;
  final data;
  final int code;
  final errors;
  final List<String> errorArray;
  final String errorMessages;

  APIResponse({this.message: '', this.data, this.code: 200, this.errors, this.errorArray, this.errorMessages});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    List<String> errorArray = [];
    String errorMessages = '';

    String multiLineString(List<String> arr) {
      StringBuffer sb = new StringBuffer();
      for (String line in arr) {
        sb.write(line + '\n');
      }
      return sb.toString().substring(0, sb.length - 2);
    }

    if (json['code'] == 401 || json['code'] == 400) {
      if (json['code'] == 401) {
        if (Helper.globalBox.get('token') != null) {
          showText(json['msg']);
          Helper.globalBox.delete('token');
          Helper.globalBox.delete('user');
          Goto.root('/');
        }
      } else {
        showText(json['msg']);
      }
    }

    if (json['code'] == 422 || json['code'] == 412) {
      Map errors = json['code'] == 412 ? json['data'] : json['errors'];
      if (errors.length > 0) {
        errors.forEach((key, val) {
          errorArray.add(val[0]);
        });
        errorMessages = multiLineString(errorArray);
        showText(errorMessages);
      }
    } else {
      if (json['code'] >= 400) {}
    }

    return APIResponse(
      message: json['message'] == null ? json['msg'] : json['message'],
      data: json['data'],
      code: json['code'],
      errors: json['errors'],
      errorArray: errorArray,
      errorMessages: errorMessages,
    );
  }

  static showText(String text) {
    BotToast.showText(
      text: text,
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
      contentColor: Config.primaryColor.withOpacity(0.8),
      duration: Duration(seconds: 5),
      contentPadding: EdgeInsets.all(16.0),
      onlyOne: true,
    );
  }
}
