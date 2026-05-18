import 'dart:developer';

extension MapExtension on Map {
  Map addCultureCode(String cultureCode) {
    this['cultureCode'] = cultureCode;
    return this;
  }

  Map<String, String>? toMapString() {
    try {
      return map(
            (key, value) => MapEntry(key.toString(), value.toString()),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Map<int, int>? toMapInt() {
    try {
      return map(
            (key, value) => MapEntry(int.parse(key.toString()), int.parse(value.toString())),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
