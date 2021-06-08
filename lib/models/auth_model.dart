import 'package:project_buddy_mobile/services/dio/api_response.dart';
import 'package:project_buddy_mobile/services/dio/dio_client.dart';
import 'package:project_buddy_mobile/services/helper.dart';

class AuthModel {
  static Future<bool> login(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient()
        .publicPost('/auth/login', data: formData, inBackground: false);
    if (res.code != 200) return false;
    Helper.token = res.data['token'];
    Helper.user = res.data['user'];
    return true;
  }

  static Future<bool> register(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient()
        .publicPost('/auth/register', data: formData, inBackground: false);
    if (res.code != 200) return false;
    return true;
  }

  static Future<bool> verifyEmail(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient()
        .publicPost('/auth/verify-email', data: formData, inBackground: false);
    if (res.code != 200) return false;
    return true;
  }

  static Future<bool> checkToken(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient()
        .publicPost('/auth/check-token', data: formData, inBackground: false);
    if (res.code != 200) return false;
    return true;
  }

  static Future<bool> forgotPassword(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient().publicPost('/auth/forgot-password',
        data: formData, inBackground: false);
    if (res.code != 200) return false;
    return true;
  }

  static Future<bool> setNewPassword(Map<String, dynamic> formData) async {
    APIResponse res = await DioClient().publicPost('/auth/set-new-password',
        data: formData, inBackground: false);
    if (res.code != 200) return false;
    return true;
  }

  static Future<bool> logout() async {
    APIResponse res = await DioClient()
        .privatePost('/auth/logout', data: {}, inBackground: false);
    if (res.code != 200) return false;
    Helper.globalBox.delete('token');
    Helper.globalBox.delete('user');
    return true;
  }
}
