import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color/app_color.dart';

const _textStyleHeight = 1.2;
const _letterSpacing = 0.0;

// enum FontW { regular, medium, semiBold, bold }

extension FontWeightExtension on FontWeight {
  static FontWeight get regular => FontWeight.w400;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get semiBold => FontWeight.w600;
  static FontWeight get bold => FontWeight.w700;
}

TextStyle mainFont(double fontSize, FontWeight fontW) {
  return GoogleFonts.mulish(
      fontSize: fontSize,
      fontWeight: fontW,
      color: AppColors.textPrimary,
      height: _textStyleHeight,
      letterSpacing: _letterSpacing);
}

class AppFonts {
  static var f8r = mainFont(8, FontWeightExtension.regular);
  static var f8m = mainFont(8, FontWeightExtension.medium);
  static var f8s = mainFont(8, FontWeightExtension.semiBold);
  static var f8b = mainFont(8, FontWeightExtension.bold);
  static var f9r = mainFont(9, FontWeightExtension.regular);
  static var f9m = mainFont(9, FontWeightExtension.medium);
  static var f9s = mainFont(9, FontWeightExtension.semiBold);
  static var f9b = mainFont(9, FontWeightExtension.bold);
  static var f10r = mainFont(10, FontWeightExtension.regular);
  static var f10m = mainFont(10, FontWeightExtension.medium);
  static var f10s = mainFont(10, FontWeightExtension.semiBold);
  static var f10b = mainFont(10, FontWeightExtension.bold);
  static var f12r = mainFont(11, FontWeightExtension.regular);
  static var f12m = mainFont(12, FontWeightExtension.medium);
  static var f12s = mainFont(12, FontWeightExtension.semiBold);
  static var f12b = mainFont(12, FontWeightExtension.bold);
  static var f14r = mainFont(14, FontWeightExtension.regular);
  static var f14m = mainFont(14, FontWeightExtension.medium);
  static var f14s = mainFont(14, FontWeightExtension.semiBold);
  static var f14b = mainFont(14, FontWeightExtension.bold);
  static var f16r = mainFont(16, FontWeightExtension.regular);
  static var f16m = mainFont(16, FontWeightExtension.medium);
  static var f16s = mainFont(16, FontWeightExtension.semiBold);
  static var f16b = mainFont(16, FontWeightExtension.bold);
  static var f18r = mainFont(18, FontWeightExtension.regular);
  static var f18m = mainFont(18, FontWeightExtension.medium);
  static var f18s = mainFont(18, FontWeightExtension.semiBold);
  static var f18b = mainFont(18, FontWeightExtension.bold);
  static var f20r = mainFont(20, FontWeightExtension.regular);
  static var f20m = mainFont(20, FontWeightExtension.medium);
  static var f20s = mainFont(20, FontWeightExtension.semiBold);
  static var f20b = mainFont(20, FontWeightExtension.bold);
}
