import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingLifestyleStep extends StatelessWidget {
  const OnboardingLifestyleStep({
    super.key,
    required this.catName,
    required this.selectedLifestyle,
    required this.onChanged,
  });

  final String catName;
  final String selectedLifestyle;
  final ValueChanged<String> onChanged;

  static const _options = [
    _LifestyleOption(value: 'Indoor', emoji: '🏠', label: 'Indoor', description: 'Lives inside full time'),
    _LifestyleOption(value: 'Outdoor', emoji: '🌿', label: 'Outdoor', description: 'Goes outside regularly'),
    _LifestyleOption(value: 'Mixed', emoji: '↔️', label: 'Mixed', description: 'In and out'),
  ];

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Where does $displayName live?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text(
          'Helps us tailor activity and health advice.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(32),
        Row(
          children: _options.map((opt) {
            final isSelected = selectedLifestyle == opt.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: opt == _options.last ? 0 : 10,
                ),
                child: GestureDetector(
                  onTap: () => onChanged(opt.value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 120,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.lavenderLight : AppColors.lavenderWash,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.lavenderDeep : AppColors.lavenderLight,
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.lavenderDeep.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
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
                              Text(opt.emoji, style: const TextStyle(fontSize: 30)),
                              const Gap(8),
                              Text(
                                opt.label,
                                style: AppFonts.h4.apply(
                                  color: isSelected ? AppColors.lavenderDeep : AppColors.charcoal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: 8,
                            right: 8,
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
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LifestyleOption {
  const _LifestyleOption({
    required this.value,
    required this.emoji,
    required this.label,
    required this.description,
  });

  final String value;
  final String emoji;
  final String label;
  final String description;
}
