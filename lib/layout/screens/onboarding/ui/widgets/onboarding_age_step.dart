import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingAgeStep extends StatefulWidget {
  const OnboardingAgeStep({
    super.key,
    required this.catName,
    required this.initialAgeYears,
    required this.initialAgeMonths,
    required this.onYearsChanged,
    required this.onMonthsChanged,
  });

  final String catName;
  final int initialAgeYears;
  final int initialAgeMonths;
  final ValueChanged<int> onYearsChanged;
  final ValueChanged<int> onMonthsChanged;

  @override
  State<OnboardingAgeStep> createState() => _OnboardingAgeStepState();
}

class _OnboardingAgeStepState extends State<OnboardingAgeStep> {
  late final FixedExtentScrollController _yearsController;
  late final FixedExtentScrollController _monthsController;
  late int _selectedYears;
  late int _selectedMonths;

  static const List<String> _yearLabels = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20+',
  ];

  static const List<String> _monthLabels = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11',
  ];

  @override
  void initState() {
    super.initState();
    _selectedYears = widget.initialAgeYears;
    _selectedMonths = widget.initialAgeMonths;
    _yearsController = FixedExtentScrollController(initialItem: widget.initialAgeYears);
    _monthsController = FixedExtentScrollController(initialItem: widget.initialAgeMonths);
  }

  @override
  void dispose() {
    _yearsController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How old is $displayName?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text('Helps us tailor care advice to their life stage.', style: AppFonts.bodyM.apply(color: AppColors.stone)),
        const Gap(32),
        Row(
          children: [
            Expanded(child: _WheelColumn(label: 'Years', controller: _yearsController, labels: _yearLabels, selectedIndex: _selectedYears, onChanged: (i) { setState(() => _selectedYears = i); widget.onYearsChanged(i); })),
            const Gap(12),
            Expanded(child: _WheelColumn(label: 'Months', controller: _monthsController, labels: _monthLabels, selectedIndex: _selectedMonths, onChanged: (i) { setState(() => _selectedMonths = i); widget.onMonthsChanged(i); })),
          ],
        ),
      ],
    );
  }
}

class _WheelColumn extends StatelessWidget {
  const _WheelColumn({
    required this.label,
    required this.controller,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final String label;
  final FixedExtentScrollController controller;
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppFonts.captionL.apply(color: AppColors.stone)),
        const Gap(8),
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.lavenderLight.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 52,
                perspective: 0.003,
                diameterRatio: 2.8,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: onChanged,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: labels.length,
                  builder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return Center(
                      child: Text(
                        labels[index],
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
