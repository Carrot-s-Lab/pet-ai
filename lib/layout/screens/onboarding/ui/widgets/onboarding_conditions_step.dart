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
    _ConditionItem(value: 'Allergies', emoji: '🤧'),
    _ConditionItem(value: 'Asthma', emoji: '🫁'),
    _ConditionItem(value: 'Diabetes', emoji: '💉'),
    _ConditionItem(value: 'Kidney Disease', emoji: '🫘'),
    _ConditionItem(value: 'Heart Disease', emoji: '❤️'),
    _ConditionItem(value: 'Hyperthyroidism', emoji: '🦋'),
    _ConditionItem(value: 'Dental Disease', emoji: '🦷'),
    _ConditionItem(value: 'Obesity', emoji: '⚖️'),
    _ConditionItem(value: 'Arthritis', emoji: '🦴'),
    _ConditionItem(value: 'Cancer', emoji: '🎗️'),
    _ConditionItem(value: 'Digestive Issues', emoji: '🔄'),
    _ConditionItem(value: 'Skin Condition', emoji: '🩹'),
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
        Text(
          'Select all that apply to $displayName. You can skip if none.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemCount: _conditions.length,
          itemBuilder: (context, i) {
            final item = _conditions[i];
            final isSelected = selectedConditions.contains(item.value);
            return _ConditionCard(
              item: item,
              isSelected: isSelected,
              onTap: () => onToggle(item.value),
            );
          },
        ),
      ],
    );
  }
}

class _ConditionCard extends StatelessWidget {
  const _ConditionCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _ConditionItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lavenderLight : AppColors.lavenderWash,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.lavenderDeep : AppColors.lavenderLight,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.lavenderDeep.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.emoji, style: const TextStyle(fontSize: 28)),
                  const Gap(6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      item.value,
                      style: AppFonts.captionM.apply(
                        color: isSelected ? AppColors.lavenderDeep : AppColors.charcoal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.lavenderDeep,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded, size: 11, color: AppColors.appWhite),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ConditionItem {
  const _ConditionItem({required this.value, required this.emoji});
  final String value;
  final String emoji;
}
