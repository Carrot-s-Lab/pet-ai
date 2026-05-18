import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class PercentageTag extends StatelessWidget {
  const PercentageTag({
    super.key,
    required this.percentage,
    this.height,
  });

  final String percentage;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$percentage%',
        style: AppFonts.f12b.apply(color: Colors.white),
      ),
    );
  }
}
