import 'dart:convert';

import 'package:pet_ai_project/data/models/cat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'keys.dart';

class LocalDatabaseService {

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    updateSessionNumber();
    incrementTipRotation();
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

  Future<void> incrementTipRotation() async {
    final current = getTipRotation();
    await _prefs.setInt(LocalDatabaseKeys.tipRotation, current + 1);
  }

  int getTipRotation() {
    return _prefs.getInt(LocalDatabaseKeys.tipRotation) ?? 0;
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool(LocalDatabaseKeys.onboardingCompleted) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(LocalDatabaseKeys.onboardingCompleted, true);
  }

  int getFreeMessageCount() {
    return _prefs.getInt(LocalDatabaseKeys.freeMessageCount) ?? 0;
  }

  Future<void> incrementFreeMessageCount() async {
    await _prefs.setInt(LocalDatabaseKeys.freeMessageCount, getFreeMessageCount() + 1);
  }

  bool isPremium() {
    return _prefs.getBool(LocalDatabaseKeys.isPremium) ?? false;
  }

  Future<void> setPremium(bool value) async {
    await _prefs.setBool(LocalDatabaseKeys.isPremium, value);
  }

  Future<void> saveCatProfile(Cat cat) async {
    await _prefs.setString(LocalDatabaseKeys.catProfile, jsonEncode(cat.toJson()));
  }

  Cat? getCatProfile() {
    final raw = _prefs.getString(LocalDatabaseKeys.catProfile);
    if (raw == null) return null;
    try {
      return Cat.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}
