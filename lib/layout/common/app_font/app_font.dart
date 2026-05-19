import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color/app_color.dart';

extension FontWeightExtension on FontWeight {
  static FontWeight get regular => FontWeight.w400;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get semiBold => FontWeight.w600;
  static FontWeight get bold => FontWeight.w700;
}

// Body text — system default (SF Pro on iOS)
TextStyle mainFont(double fontSize, FontWeight fontW) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontW,
    color: AppColors.ink,
    height: 1.4,
    letterSpacing: 0.0,
  );
}

// Brand / display text — Nunito (Kenfolg stand-in: warm, rounded)
TextStyle brandFont(double fontSize, FontWeight fontW, {double height = 1.2, double letterSpacing = 0.0}) {
  return GoogleFonts.nunito(
    fontSize: fontSize,
    fontWeight: fontW,
    color: AppColors.ink,
    height: height,
    letterSpacing: letterSpacing,
  );
}

class AppFonts {
  // === BODY STYLES (system font — SF Pro on iOS) ===
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
  static var f11r = mainFont(11, FontWeightExtension.regular);
  static var f11m = mainFont(11, FontWeightExtension.medium);
  static var f11s = mainFont(11, FontWeightExtension.semiBold);
  static var f11b = mainFont(11, FontWeightExtension.bold);
  static var f12r = mainFont(12, FontWeightExtension.regular);
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

  // === BRAND DISPLAY (Nunito — Kenfolg stand-in) ===
  static var displayXl = brandFont(40, FontWeightExtension.bold, letterSpacing: -0.5);
  static var displayL = brandFont(32, FontWeightExtension.semiBold, letterSpacing: -0.3);
  static var displayM = brandFont(28, FontWeightExtension.semiBold, letterSpacing: -0.2);

  // === HEADINGS (Nunito) ===
  static var h1 = brandFont(26, FontWeightExtension.semiBold, letterSpacing: -0.2);
  static var h2 = brandFont(22, FontWeightExtension.semiBold, letterSpacing: -0.1);
  static var h3 = brandFont(18, FontWeightExtension.medium);
  static var h4 = brandFont(16, FontWeightExtension.medium);

  // === CTA (Nunito) ===
  static var ctaPrimary = brandFont(17, FontWeightExtension.semiBold, letterSpacing: 0.2);
  static var ctaSecondary = brandFont(15, FontWeightExtension.medium, letterSpacing: 0.1);
  static var ctaTertiary = brandFont(14, FontWeightExtension.regular);

  // === SEMANTIC BODY (system font) ===
  static var bodyL = mainFont(17, FontWeightExtension.regular);
  static var bodyM = mainFont(15, FontWeightExtension.regular);
  static var bodyS = mainFont(13, FontWeightExtension.regular);
  static var captionL = mainFont(13, FontWeightExtension.medium);
  static var captionM = mainFont(12, FontWeightExtension.regular);
  static var captionS = mainFont(11, FontWeightExtension.regular);
}
