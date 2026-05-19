import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingLoadingStep extends StatefulWidget {
  const OnboardingLoadingStep({
    super.key,
    required this.catName,
    required this.onComplete,
  });

  final String catName;
  final VoidCallback onComplete;

  @override
  State<OnboardingLoadingStep> createState() => _OnboardingLoadingStepState();
}

class _OnboardingLoadingStepState extends State<OnboardingLoadingStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnim = CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut);

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            'assets/images/cat_loading.png',
            fit: BoxFit.contain,
          ),
        ),
        const Gap(20),
        FadeTransition(
          opacity: _pulseAnim,
          child: Text(
            'Building $displayName\'s profile…',
            style: AppFonts.h3.apply(color: AppColors.lavenderDeep),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(48),
      ],
    );
  }
}
