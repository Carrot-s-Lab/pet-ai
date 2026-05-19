import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingConditionsStep extends StatelessWidget {
  const OnboardingConditionsStep({
    super.key,
    required this.catName,
    required this.selectedConditions,
    required this.onToggle,
  });

  final String catName;
  final List<String> selectedConditions;
  final ValueChanged<String> onToggle;

  static const _conditions = [
    'Allergies',
    'Asthma',
    'Diabetes',
    'Kidney Disease',
    'Heart Disease',
    'Hyperthyroidism',
    'Dental Disease',
    'Obesity',
    'Arthritis',
    'Cancer',
    'Digestive Issues',
    'Skin Condition',
  ];

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Any special conditions?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text('Select all that apply to $displayName. You can skip if none.', style: AppFonts.bodyM.apply(color: AppColors.stone)),
        const Gap(32),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _conditions.map((condition) {
            final isSelected = selectedConditions.contains(condition);
            return GestureDetector(
              onTap: () => onToggle(condition),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.lavenderLight : AppColors.inputSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppColors.lavenderDeep : AppColors.mist,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.check, size: 16, color: AppColors.lavenderDeep),
                      const Gap(6),
                    ],
                    Text(
                      condition,
                      style: AppFonts.bodyS.apply(color: isSelected ? AppColors.lavenderDeep : AppColors.charcoal),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
