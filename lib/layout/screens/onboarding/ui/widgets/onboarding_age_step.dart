import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingAgeStep extends StatefulWidget {
  const OnboardingAgeStep({
    super.key,
    required this.catName,
    required this.initialAgeIndex,
    required this.onChanged,
  });

  final String catName;
  final int initialAgeIndex;
  final ValueChanged<int> onChanged;

  @override
  State<OnboardingAgeStep> createState() => _OnboardingAgeStepState();
}

class _OnboardingAgeStepState extends State<OnboardingAgeStep> {
  late final FixedExtentScrollController _scrollController;
  late int _selectedIndex;

  static const List<String> _ageLabels = [
    'Less than 1 year',
    '1 year',
    '2 years',
    '3 years',
    '4 years',
    '5 years',
    '6 years',
    '7 years',
    '8 years',
    '9 years',
    '10 years',
    '11 years',
    '12 years',
    '13 years',
    '14 years',
    '15 years',
    '16 years',
    '17 years',
    '18 years',
    '19 years',
    '20+ years',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialAgeIndex;
    _scrollController = FixedExtentScrollController(initialItem: widget.initialAgeIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How old is $displayName?',
          style: AppFonts.displayM.apply(color: AppColors.ink),
        ),
        const Gap(8),
        Text(
          'Helps us tailor health advice to their life stage.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(32),
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Selection band
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: AppColors.caramelLight.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: 52,
                perspective: 0.003,
                diameterRatio: 2.8,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() => _selectedIndex = index);
                  widget.onChanged(index);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _ageLabels.length,
                  builder: (context, index) {
                    final isSelected = _selectedIndex == index;
                    return Center(
                      child: Text(
                        _ageLabels[index],
                        style: isSelected
                            ? AppFonts.h3.apply(color: AppColors.ink)
                            : AppFonts.bodyM.apply(color: AppColors.pebble),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
