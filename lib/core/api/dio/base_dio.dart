import 'dart:async';
import 'dart:convert';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../app_config/env/evn_config.dart';
import 'dio_interceptor.dart';

class BaseDio {
  Dio dio = Dio();

  // RefreshTokenService refreshTokenService = RefreshTokenService();

  BaseDio() {
    init(url: EnvConfig.baseUrl());
    setToken(EnvConfig.code());
  }

  String cultureCode = 'vi-VN';

  void init({required String url}) {
    dio.interceptors.add(
      AwesomeDioInterceptor(logRequestTimeout: true, logRequestHeaders: true, logResponseHeaders: true),
    );
    dio.options.baseUrl = url;

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    dio.options.connectTimeout = const Duration(seconds: 15); //60s
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.options.headers = header;
    dio.interceptors.add(DioInterceptor());
  }

  void setToken(String? token) {
    dio.options.headers['Authorization'] = token;
  }

  void removeToken() {
    dio.options.headers.remove('Authorization');
  }

  // void setRefreshToken(String? refreshToken) {
  //   refreshTokenService.setToken(refreshToken);
  // }
  //
  // void removeRefreshToken() {
  //   refreshTokenService.removeToken();
  // }

  Future<Response> getRequest({required String url, dynamic body, bool shouldRunRefreshToken = true}) async {
    try {
      Response res;
      if (body != null) {
        res = await dio.get(url, data: body);
      } else {
        res = await dio.get(url);
      }
      return res;
    } catch (ex) {
      return handleException(
        dioException: ex,
        retryRequest: () => getRequest(url: url, body: body, shouldRunRefreshToken: false),
        shouldRunRefreshToken: shouldRunRefreshToken,
      );
    }
  }

  Future<Response> postRequest({
    required String url,
    dynamic body,
    Function(int a, int b)? progressFunc,
    bool shouldRunRefreshToken = true,
  }) async {
    try {
      Response res;
      if (body != null) {
        res = await dio.post(
          url,
          data: body,
          onSendProgress: (count, total) {
            if (progressFunc != null) {
              progressFunc(count, total);
            }
          },
        );
      } else {
        res = await dio.post(url);
      }
      return res;
    } catch (ex) {
      return handleException(
        dioException: ex,
        retryRequest: () => postRequest(url: url, body: body, shouldRunRefreshToken: false),
        shouldRunRefreshToken: shouldRunRefreshToken,
      );
    }
  }

  Future<Response> putRequest({
    required String url,
    dynamic body,
    Function(int a, int b)? progressFunc,
    bool shouldRunRefreshToken = true,
  }) async {
    try {
      Response res = await dio.put(
        url,
        data: body,
        onSendProgress: (count, total) {
          if (progressFunc != null) {
            progressFunc(count, total);
          }
        },
      );
      return res;
    } catch (ex) {
      return handleException(
        dioException: ex,
        retryRequest: () => deleteRequest(url: url, body: body, shouldRunRefreshToken: false),
        shouldRunRefreshToken: shouldRunRefreshToken,
      );
    }
  }

  Future<Response> deleteRequest({required String url, dynamic body, bool shouldRunRefreshToken = true}) async {
    try {
      Response res;
      if (body != null) {
        res = await dio.delete(url, data: body);
      } else {
        res = await dio.delete(url);
      }
      return res;
    } catch (ex) {
      return handleException(
        dioException: ex,
        retryRequest: () => deleteRequest(url: url, body: body, shouldRunRefreshToken: false),
        shouldRunRefreshToken: shouldRunRefreshToken,
      );
    }
  }

  Future<Response> handleException({
    required dynamic dioException,
    required Future<Response> Function() retryRequest,
    bool shouldRunRefreshToken = true,
  }) async {
    final exResponse = createExResponse(dioException);

    /// If the status code is 401 and the refresh token is enabled, call the refresh token method
    if (exResponse.statusCode == 401 && shouldRunRefreshToken) {
      // final newToken = await refreshTokenService.execute();
      // if (newToken?.accessToken != null) {
      //   setToken(newToken!.accessToken!);
      //   return await retryRequest();
      // }
    }
    handleErrors(exResponse);
    return exResponse;
  }

  Response createExResponse(dynamic ex) {
    DioException dioException = ex as DioException;
    final statusCode = dioException.response?.statusCode;
    final headers = dioException.response?.headers;
    dynamic data;
    try {
      final jsonData = json.decode(ex.response.toString());
      data = jsonData;
    } catch (e) {
      // print(e.toString());
    }

    final res = Response(
      statusCode: statusCode,
      requestOptions: dioException.requestOptions,
      statusMessage: dioException.message,
      data: data,
      headers: headers,
      extra: {'type': dioException.type},
    );
    return res;
  }

  void handleErrors(Response<dynamic> exResponse) {
    // if (exResponse.statusCode == 401 && locator<AppRepository>().userModel != null) {
    //   locator<AppRepository>().logOut();
    // }
    // if (dioExceptions.response!.statusCode == 401 && AppController.find().isLoggedIn) {
    //   final List<String> noLogOutPath = ['/api/notifications/parent_noti', '/api/notifications/tutor_noti'];
    //   if (!noLogOutPath.contains(dioExceptions.requestOptions.path)) {
    //     AppController appController = _get.Get.find();
    //     appController.callLogOut();
    //   }
    // }
  }
}
