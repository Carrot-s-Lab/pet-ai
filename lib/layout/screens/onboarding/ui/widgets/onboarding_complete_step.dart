import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingCompleteStep extends StatelessWidget {
  const OnboardingCompleteStep({super.key, required this.catName});

  final String catName;

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/app_logo.png',
          height: 180,
          fit: BoxFit.contain,
        ),
        const Gap(40),
        Text(
          'You\'re all set!',
          style: AppFonts.displayM.apply(color: AppColors.ink),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          '$displayName\'s care companion is ready.',
          style: AppFonts.bodyL.apply(color: AppColors.stone),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
