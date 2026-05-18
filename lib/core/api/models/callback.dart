import 'dart:developer';

import 'package:pet_ai_project/generated/l10n.dart';

import 'error.dart';

class ApiCallBack<T> {
  ApiCallBack({
    required this.data,
    required this.success,
    required this.statusCode,
    this.error,
    this.message,
    this.timestamp,
  });

  final bool success;
  final int? statusCode;
  final T? data;
  final ApiError? error;
  final String? message;
  final String? timestamp;

  String get firstErrorMessage =>
      error?.errorMessage?.first ?? Tr.current.somethingWentWrong;

  factory ApiCallBack.fromJson({
    required Map<String, dynamic>? json,
    T Function(dynamic)? dataFromJson,
  }) {
    if (json == null) {
      log('json is null');
      return ApiCallBack(
        data: null,
        success: false,
        statusCode: null,
        error: ApiError(errorMessage: [Tr.current.somethingWentWrong]),
        message: null,
        timestamp: null,
      );
    }
    try {
      return ApiCallBack(
        data: dataFromJson?.call(json['data']),
        success: json['statusSuccess'] as bool,
        statusCode: json['statusCode'] as int,
        error: ApiError.fromJson(json['errors']),
        message: json['message'] as String,
        timestamp: json['timestamp'] as String,
      );
    } catch (e) {
      return ApiCallBack(
        data: dataFromJson?.call(json['data']),
        success: false,
        statusCode: json['statusCode'] as int?,
        error: ApiError(errorMessage: [e.toString()]),
        message: json['message'] as String?,
        timestamp: json['timestamp'] as String?,
      );
    }
  }
}
