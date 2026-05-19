import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === BRAND: Caramel ===
  static const Color caramel = Color(0xFFD39654);
  static const Color caramelDeep = Color(0xFFB87A3A);
  static const Color caramelLight = Color(0xFFF2DFC0);
  static const Color caramelWash = Color(0xFFFBF5EC);

  // === AI: Lavender ===
  static const Color lavender = Color(0xFFB8ACE5);
  static const Color lavenderDeep = Color(0xFF8E7FCC);
  static const Color lavenderLight = Color(0xFFDDD8F5);
  static const Color lavenderWash = Color(0xFFF3F1FB);

  // === NEUTRALS ===
  static const Color ink = Color(0xFF1A1611);
  static const Color charcoal = Color(0xFF3D3529);
  static const Color stone = Color(0xFF7A6E62);
  static const Color pebble = Color(0xFFB5ADA4);
  static const Color mist = Color(0xFFE8E3DC);
  static const Color cloud = Color(0xFFF5F2EE);
  static const Color appWhite = Color(0xFFFEFDFB);

  // === SEMANTIC ===
  static const Color wellness = Color(0xFF5BAD7F);
  static const Color amber = Color(0xFFE8A020);
  static const Color urgent = Color(0xFFD94040);
  static const Color info = Color(0xFF5B8DD9);

  // === BACKGROUNDS ===
  static const Color appBackground = Color(0xFFFEFDFB);
  static const Color sectionBackground = Color(0xFFFBF5EC);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color inputSurface = Color(0xFFF5F2EE);

  // === BACKWARD-COMPATIBLE ALIASES ===
  static Color get primaryColor => caramel;
  static Color get blue => caramel;
  static Color get darkBlue => caramelDeep;
  static Color get lightBlue => caramelLight;
  static Color get textPrimary => ink;
  static Color get textSecondary => charcoal;
  static Color get textTertiary => stone;
  static Color get textQuaternary => pebble;
  static Color get surfacePrimary => cloud;
  static Color get surfaceSecondary => mist;
  static Color get surfaceTertiary => cloud;
  static Color get borderPrimary => mist;
  static Color get borderColor => mist;
  static Color get red => urgent;
  static Color get redLighter => const Color(0xFFF9E8E8);
  static Color get green => wellness;
  static Color get orange => amber;
  static Color get lightOrange => caramelWash;
  static Color get selectedSurface => caramelWash;
  static const Color white = Color(0xFFFFFFFF);
  static Color get lightGrey => mist;
  static Color get backgroundColor => appBackground;
  static Color get incorrect => urgent;
  static Color get incorrectLight => const Color(0xFFFBEEEC);
  static Color get lightIncorrect => const Color(0xFFFBEEEC);
  static Color get greyTextColor => stone;
  static Color get lightTextColor => pebble;
  static Color get grey => pebble;
  static Color get questionTnBorder => lavender;
  static Color get questionTnBorderLighter => lavenderLight;
  static Color get questionTnBackground => lavenderWash;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
