import 'dart:developer';

import 'package:dio/dio.dart';

// import 'package:dio/src/form_data.dart' as dio_form_data;
// import 'package:dio/dio.dart' as dio_form_data;
// import 'package:education_app/core/extensions/form_data.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // print(
    //     'ERROR[${err.response?.statusCode}] => MESSAGE: ${err.response?.statusMessage ?? "No Message"}\n${err.toString()}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('===> REQUEST<${options.method}>\n[PATH]: ${options.path}');

    if (options.data != null) {
      // if (options.data is dio_form_data.FormData) {
      //   final formData = options.data as dio_form_data.FormData;
      //   print('REQUEST[${options.method}] => FORMDATA:');
      //   formData.printValues();
      // } else {
      log('[BODY]: ${options.data.toString()}');
      // }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
    '<=== RESPONSE<${response.statusCode}>\nBODY: ${response.data.toString()}',
    );
    return super.onResponse(response, handler);
  }
}
