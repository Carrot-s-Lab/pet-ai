import 'package:shared_preferences/shared_preferences.dart';

import 'keys.dart';

class LocalDatabaseService {

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    updateSessionNumber();
  }

  Future<void> saveLocale(String locale) async {
    await _prefs.setString(LocalDatabaseKeys.locale, locale);
  }

  String getLocaleCode() {
    print('getLocaleCode: ${_prefs.getString(LocalDatabaseKeys.locale)}');
    return _prefs.getString(LocalDatabaseKeys.locale) ?? 'en';
  }

  Future<void> updateSessionNumber({int? sessionNumber}) async {
    if (sessionNumber != null) {
      await _prefs.setInt(LocalDatabaseKeys.session, sessionNumber);
    } else {
      final sessionNumber = getSessionNumber();
      await _prefs.setInt(LocalDatabaseKeys.session, sessionNumber + 1);
    }
  }

  int getSessionNumber() {
    return _prefs.getInt(LocalDatabaseKeys.session) ?? 0;
  }
}
