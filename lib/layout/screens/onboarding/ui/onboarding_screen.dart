import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/buttons/app_back_button.dart';
import 'package:pet_ai_project/layout/common/buttons/app_button.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/core/services/local_database/local_database_service.dart';
import 'package:pet_ai_project/layout/screens/onboarding/controller/onboarding_controller.dart';
import 'package:pet_ai_project/router/route_paths.dart';
import 'widgets/onboarding_age_step.dart';
import 'widgets/onboarding_breed_step.dart';
import 'widgets/onboarding_complete_step.dart';
import 'widgets/onboarding_conditions_step.dart';
import 'widgets/onboarding_name_step.dart';
import 'widgets/onboarding_photo_step.dart';
import 'widgets/onboarding_progress_dots.dart';
import 'widgets/onboarding_sex_step.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Consumer<OnboardingController>(
          builder: (context, controller, _) {
            final step = controller.step;
            final showBack = step >= 1 && step <= 5;
            final showDots = step <= 5;
            final isComplete = step == 6;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isComplete
                      ? [AppColors.lavender, AppColors.lavenderLight]
                      : [AppColors.lavenderLight, AppColors.lavenderWash],
                ),
              ),
              child: Stack(
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 56,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                if (showBack) AppBackButton(onTap: controller.previousStep) else const SizedBox(width: 40),
                                const Spacer(),
                                if (showDots) OnboardingProgressDots(activeIndex: step, total: 6),
                                const Spacer(),
                                const SizedBox(width: 40),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            transitionBuilder: (child, animation) {
                              final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
                              return FadeTransition(
                                opacity: curved,
                                child: SlideTransition(
                                  position: Tween<Offset>(begin: const Offset(0.06, 0), end: Offset.zero).animate(curved),
                                  child: child,
                                ),
                              );
                            },
                            child: _StepContent(key: ValueKey(step), controller: controller, step: step),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                          child: _buildCta(context, controller, step),
                        ),
                      ],
                    ),
                  ),

                  if (isComplete)
                    const IgnorePointer(child: _ConfettiOverlay()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCta(BuildContext context, OnboardingController controller, int step) {
    Widget skipButton() => TextButton(
      onPressed: controller.nextStep,
      child: Text('Skip for now', style: AppFonts.ctaTertiary.apply(color: AppColors.stone)),
    );

    final enabled = controller.canContinue;

    return switch (step) {
      0 => AppButton(text: 'Continue', isEnabled: enabled, onTap: enabled ? controller.nextStep : null),
      1 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', isEnabled: enabled, onTap: enabled ? controller.nextStep : null), const Gap(4), skipButton()],
      ),
      2 => AppButton(text: 'Continue', onTap: controller.nextStep),
      3 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', isEnabled: enabled, onTap: enabled ? controller.nextStep : null), const Gap(4), skipButton()],
      ),
      4 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', isEnabled: enabled, onTap: enabled ? controller.nextStep : null), const Gap(4), skipButton()],
      ),
      5 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', isEnabled: enabled, onTap: enabled ? controller.nextStep : null), const Gap(4), skipButton()],
      ),
      6 => AppButton(
        text: controller.catName.isNotEmpty ? 'Start with ${controller.catName}' : 'Start exploring',
        onTap: () async {
          await locator<LocalDatabaseService>().setOnboardingCompleted();
          if (context.mounted) context.go(RoutePaths.home);
        },
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

// ─────────────────────────────────────────────
// Confetti
// ─────────────────────────────────────────────

class _ConfettiOverlay extends StatefulWidget {
  const _ConfettiOverlay();

  @override
  State<_ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<_ConfettiOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_Particle> _particles;

  static const _colors = [
    AppColors.caramel,
    AppColors.caramelDeep,
    AppColors.lavenderDeep,
    AppColors.lavender,
    AppColors.wellness,
    AppColors.caramelLight,
    AppColors.appWhite,
  ];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _particles = List.generate(80, (_) {
      return _Particle(
        x: rng.nextDouble(),
        vx: (rng.nextDouble() - 0.5) * 0.4,
        vy: 0.2 + rng.nextDouble() * 0.5,
        size: 4 + rng.nextDouble() * 6,
        color: _colors[rng.nextInt(_colors.length)],
        rotation: rng.nextDouble() * pi * 2,
        rotationSpeed: (rng.nextBool() ? 1 : -1) * (0.5 + rng.nextDouble()),
        isCircle: rng.nextBool(),
        delay: rng.nextDouble() * 0.4,
      );
    });

    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => CustomPaint(
        painter: _ConfettiPainter(progress: _ctrl.value, particles: _particles),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _Particle {
  const _Particle({
    required this.x,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.isCircle,
    required this.delay,
  });

  final double x;
  final double vx;
  final double vy;
  final double size;
  final Color color;
  final double rotation;
  final double rotationSpeed;
  final bool isCircle;
  final double delay;
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({required this.progress, required this.particles});

  final double progress;
  final List<_Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = ((progress - p.delay) / (1.0 - p.delay)).clamp(0.0, 1.0);
      if (t <= 0) continue;

      final x = p.x * size.width + p.vx * t * size.width;
      final y = -24.0 + p.vy * t * size.height + 0.6 * t * t * size.height;
      final opacity = t > 0.65 ? (1.0 - t) / 0.35 : 1.0;
      if (opacity <= 0) continue;

      final paint = Paint()..color = p.color.withValues(alpha: opacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + p.rotationSpeed * t * pi * 4);

      if (p.isCircle) {
        canvas.drawCircle(Offset.zero, p.size / 2, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5),
          paint,
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────
// Step content
// ─────────────────────────────────────────────

class _StepContent extends StatelessWidget {
  const _StepContent({super.key, required this.controller, required this.step});

  final OnboardingController controller;
  final int step;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          _buildStepWidget(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStepWidget() {
    return switch (step) {
      0 => OnboardingNameStep(initialName: controller.catName, onChanged: controller.updateCatName),
      1 => OnboardingPhotoStep(catName: controller.catName, photo: controller.catPhoto, onPhotoSelected: controller.updateCatPhoto),
      2 => OnboardingAgeStep(
          catName: controller.catName,
          initialAgeYears: controller.catAgeYears,
          initialAgeMonths: controller.catAgeMonths,
          onYearsChanged: controller.updateCatAgeYears,
          onMonthsChanged: controller.updateCatAgeMonths,
        ),
      3 => OnboardingSexStep(catName: controller.catName, selectedSex: controller.catSex, onChanged: controller.updateCatSex),
      4 => OnboardingBreedStep(catName: controller.catName, initialBreed: controller.catBreed, onChanged: controller.updateCatBreed),
      5 => OnboardingConditionsStep(catName: controller.catName, selectedConditions: controller.catConditions, onToggle: controller.toggleCondition),
      6 => OnboardingCompleteStep(catName: controller.catName, catPhoto: controller.catPhoto, catBreed: controller.catBreed),
      _ => const SizedBox.shrink(),
    };
  }
}
