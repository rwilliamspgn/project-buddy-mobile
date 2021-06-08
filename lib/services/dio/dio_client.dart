import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project_buddy_mobile/env/config.dart';

import '../goto.dart';
import '../helper.dart';
import 'api_response.dart';

class DioClient {
  Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = Config.baseApiUrl;
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 10000;

    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.backgroundColor = Config.primaryColor;
    EasyLoading.instance.indicatorColor = Config.primaryColor;
  }

  Future<APIResponse> publicGet(String uri,
      {Map<String, dynamic>? data, bool inBackground: false}) async {
    print(uri);
    if (!inBackground)
      EasyLoading.show(
          status: 'Processing...', maskType: EasyLoadingMaskType.black);
    _dio.options.headers["content-type"] = 'application/json';

    final response = await this._dio.get(uri, queryParameters: data);
    if (!inBackground) EasyLoading.dismiss();
    return _process(response);
  }

  Future<APIResponse> publicPost(String uri,
      {required Map<String, dynamic> data, bool inBackground: false}) async {
    print(uri);
    if (!inBackground) EasyLoading.show(status: 'Processing...');
    _dio.options.headers["content-type"] = 'application/json';

    FormData formData = new FormData.fromMap(data);
    final response = await this._dio.post(
      uri,
      data: formData,
      onSendProgress: (int sent, int total) {
        if (sent == total) print('Full Sent');
      },
      onReceiveProgress: (int received, int total) {
        if (received == total) print('Full Received');
      },
    ).catchError((error) {
      print(error);
      if (!inBackground) EasyLoading.showToast('Something went wrong!');
    });
    if (!inBackground) EasyLoading.dismiss();
    return _process(response);
  }

  Future<APIResponse> privateGet(String uri,
      {Map<String, dynamic>? data, bool inBackground: false}) async {
    print(uri);
    if (!inBackground)
      EasyLoading.show(
          status: 'Processing...', maskType: EasyLoadingMaskType.black);
    _dio.options.headers["content-type"] = 'application/json';
    _dio.options.headers["Authorization"] = 'Bearer ${Helper.token}';

    final response =
        await this._dio.get(uri, queryParameters: data).catchError((onError) {
      print('Error Url: ($uri) $onError');
      if (!inBackground) EasyLoading.showToast('Something went wrong!');
      if (onError != null && onError.response != null) {
        if (onError.response.statusCode == 401 ||
            onError.response.statusCode == 302) {
          _logout();
        }
      }
    });
    if (!inBackground) EasyLoading.dismiss();
    return _process(response);
  }

  Future<APIResponse> privatePost(String uri,
      {required Map<String, dynamic> data, bool inBackground: false}) async {
    print(uri);
    if (!inBackground)
      EasyLoading.show(
          status: 'Processing...', maskType: EasyLoadingMaskType.black);
    _dio.options.headers["content-type"] = 'application/json';
    _dio.options.headers["Authorization"] = 'Bearer ${Helper.token}';

    FormData formData = new FormData.fromMap(data);
    final response = await this._dio.post(
      uri,
      data: formData,
      onSendProgress: (int sent, int total) {
        if (sent == total) print('Full Sent');
      },
      onReceiveProgress: (int received, int total) {
        if (received == total) print('Full Received');
      },
    ).catchError((onError) {
      print('Error Url: ($uri) $onError');
      if (!inBackground) EasyLoading.showToast('Something went wrong!');
      if (onError != null && onError.response != null) {
        if (onError.response.statusCode == 401 ||
            onError.response.statusCode == 302) {
          _logout();
        }
      }
    });
    if (!inBackground) EasyLoading.dismiss();
    return _process(response);
  }

  void _logout() {
    Helper.globalBox.delete('token');
    Helper.globalBox.delete('user');
    Goto.root('/');
  }

  APIResponse _process(Response response) {
    if (response == null)
      return APIResponse.fromJson({
        'code': 500,
        'msg': 'Server cannot be reach.',
        'data': null,
      });
    if (response.statusCode == 200) {
      return APIResponse.fromJson(response.data);
    } else {
      var body = response.data;
      body['code'] = response.statusCode;
      return APIResponse.fromJson(body);
    }
  }
}
