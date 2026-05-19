import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingSexStep extends StatelessWidget {
  const OnboardingSexStep({
    super.key,
    required this.catName,
    required this.selectedSex,
    required this.onChanged,
  });

  final String catName;
  final String selectedSex;
  final ValueChanged<String> onChanged;

  static const _options = [
    _SexOption(value: 'Male', emoji: '♂', label: 'Male'),
    _SexOption(value: 'Female', emoji: '♀', label: 'Female'),
  ];

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What\'s $displayName\'s sex?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text('Helps us give accurate care guidance.', style: AppFonts.bodyM.apply(color: AppColors.stone)),
        const Gap(32),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.4,
          children: _options.map((opt) {
            final isSelected = selectedSex == opt.value;
            return GestureDetector(
              onTap: () => onChanged(opt.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.lavenderLight : AppColors.inputSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.lavenderDeep : AppColors.mist,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(opt.emoji, style: const TextStyle(fontSize: 18)),
                    const Gap(8),
                    Text(
                      opt.label,
                      style: AppFonts.h4.apply(color: isSelected ? AppColors.lavenderDeep : AppColors.charcoal),
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

class _SexOption {
  const _SexOption({required this.value, required this.emoji, required this.label});
  final String value;
  final String emoji;
  final String label;
}
