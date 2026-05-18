import 'dart:developer';

import 'package:dio/dio.dart' as dio_form_data;

extension FormDataX on dio_form_data.FormData {

  void printValues() {
    final fields = this.fields;
    for (var field in fields) {
      final key = field.key;
      final value = field.value.length > 50 ? ('${field.value.substring(0, 50)}...') : field.value;
      log(MapEntry(key, value).toString());
    }
  }
}