import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        SvgPicture.asset(
          'assets/images/cat_onboarding_welcome.svg',
          height: 200,
          fit: BoxFit.contain,
        ),
        const Gap(32),
        Text(
          'Catti',
          style: AppFonts.displayXl.apply(color: AppColors.ink),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          'Your cat\'s AI care companion',
          style: AppFonts.bodyL.apply(color: AppColors.lavenderDeep),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
