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
  late final AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          widget.onComplete();
        }
      });
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/cat_loading.png',
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lavenderLight.withValues(alpha: 0),
                  AppColors.lavenderLight.withValues(alpha: 0.95),
                  AppColors.lavenderLight,
                ],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Setting up your profile…',
                      style: AppFonts.h3.apply(color: AppColors.ink),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(16),
                    AnimatedBuilder(
                      animation: _progressCtrl,
                      builder: (_, _) => ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: _progressCtrl.value,
                          minHeight: 6,
                          backgroundColor: AppColors.lavenderLight,
                          valueColor: const AlwaysStoppedAnimation(AppColors.lavenderDeep),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
