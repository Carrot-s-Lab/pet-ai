import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingWelcomeStep extends StatelessWidget {
  const OnboardingWelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/app_logo.png',
          height: 200,
          fit: BoxFit.contain,
        ),
        const Gap(40),
        Text(
          'Catti',
          style: AppFonts.displayXl.apply(color: AppColors.ink),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          'Your cat\'s AI health companion',
          style: AppFonts.bodyL.apply(color: AppColors.stone),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
