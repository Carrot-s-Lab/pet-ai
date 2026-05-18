import 'package:flutter/material.dart';

extension ColorExt on Color {

  ColorFilter toColorFilter({BlendMode blendMode = BlendMode.srcIn}) {
    return ColorFilter.mode(this, blendMode);
  }
}