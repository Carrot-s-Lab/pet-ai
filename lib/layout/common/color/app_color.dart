import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static final Color primaryColor = blue;
  static final Color blue = AppColors.fromHex('#3B8DC4');
  static final Color textPrimary = fromHex('#252a32');
  static final Color textSecondary = fromHex('#575F6B');
  static final Color textTertiary = fromHex('#8a929e');
  static final Color textQuaternary = fromHex('#B3BBC7');
  static final Color surfacePrimary = fromHex('#F0F4FA');
  static final Color surfaceSecondary = fromHex('#CFD6E0');
  static final Color surfaceTertiary = fromHex('#F7F8F9');
  static final Color borderPrimary = fromHex('#E1E5ED');
  static final Color red = fromHex('#E2444F');
  static final Color selectedSurface = fromHex('#E9F3F7');

  static final Color backgroundColor = AppColors.fromHex('#171717');
  static final Color orange = AppColors.fromHex('#f4990a');
  static final Color lightOrange = AppColors.fromHex('#fff9ed');
  static final Color darkBlue = AppColors.fromHex('#2d82dd');
  static final Color lightBlue = AppColors.fromHex('#e9f7fd');
  static final Color green = AppColors.fromHex('#7ec101');
  static final Color redLighter = fromHex('#F4DFDF');
  static final Color incorrect = AppColors.fromHex('#e77036');
  static final Color incorrectLight = AppColors.fromHex('#fbf0ea');
  static final Color lightIncorrect = AppColors.fromHex('#fcf0ea');
  static const Color white = Colors.white;
  static final Color greyTextColor = AppColors.fromHex('#98989e');
  static final Color lightTextColor = fromHex('#7B7C80');
  static final Color borderColor = AppColors.fromHex('#E1E5ED');
  static const Color grey = Colors.grey;
  static final Color lightGrey = AppColors.fromHex('#e7e7e7');
  static final Color questionTnBorder = AppColors.fromHex('#0088cc');
  static final Color questionTnBorderLighter = AppColors.fromHex('#d0f3ff');
  static final Color questionTnBackground = AppColors.fromHex('#e0f4fe');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}