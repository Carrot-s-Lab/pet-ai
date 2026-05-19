import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingProgressDots extends StatelessWidget {
  const OnboardingProgressDots({super.key, required this.activeIndex, required this.total});

  final int activeIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.caramel : AppColors.lavenderLight,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
