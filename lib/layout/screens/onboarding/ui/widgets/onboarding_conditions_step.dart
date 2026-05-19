import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingConditionsStep extends StatefulWidget {
  const OnboardingConditionsStep({
    super.key,
    required this.catName,
    required this.selectedConditions,
    required this.onToggle,
  });

  final String catName;
  final List<String> selectedConditions;
  final ValueChanged<String> onToggle;

  @override
  State<OnboardingConditionsStep> createState() => _OnboardingConditionsStepState();
}

class _OnboardingConditionsStepState extends State<OnboardingConditionsStep> {
  bool _open = false;

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

  String get _fieldLabel {
    final count = widget.selectedConditions.length;
    if (count == 0) return 'None selected';
    if (count == 1) return widget.selectedConditions.first;
    return '$count conditions selected';
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';

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
        const Gap(24),

        // Trigger field
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _open = !_open),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.lavenderWash,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _open ? AppColors.lavenderDeep : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.list_rounded, color: AppColors.lavenderDeep, size: 20),
                const Gap(10),
                Expanded(
                  child: Text(
                    _fieldLabel,
                    style: AppFonts.bodyL.apply(
                      color: widget.selectedConditions.isEmpty ? AppColors.pebble : AppColors.ink,
                    ),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 180),
                  turns: _open ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.lavenderDeep),
                ),
              ],
            ),
          ),
        ),

        // Dropdown list
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: _open
              ? Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: (_conditions.length * 48.0).clamp(0, 260),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.appWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.lavenderLight),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lavenderDeep.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _conditions.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.mist),
                    itemBuilder: (context, i) {
                      final condition = _conditions[i];
                      final isSelected = widget.selectedConditions.contains(condition);
                      return _ConditionRow(
                        condition: condition,
                        isSelected: isSelected,
                        onTap: () => widget.onToggle(condition),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow({required this.condition, required this.isSelected, required this.onTap});

  final String condition;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lavenderWash : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                condition,
                style: AppFonts.bodyM.apply(color: isSelected ? AppColors.lavenderDeep : AppColors.ink),
              ),
            ),
            if (isSelected) const Icon(Icons.check_rounded, size: 18, color: AppColors.lavenderDeep),
          ],
        ),
      ),
    );
  }
}
