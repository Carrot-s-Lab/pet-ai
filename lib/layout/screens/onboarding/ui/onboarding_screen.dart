import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/buttons/app_back_button.dart';
import 'package:pet_ai_project/layout/common/buttons/app_button.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:pet_ai_project/layout/screens/onboarding/controller/onboarding_controller.dart';
import 'package:pet_ai_project/router/route_paths.dart';
import 'widgets/onboarding_age_step.dart';
import 'widgets/onboarding_complete_step.dart';
import 'widgets/onboarding_name_step.dart';
import 'widgets/onboarding_photo_step.dart';
import 'widgets/onboarding_progress_dots.dart';
import 'widgets/onboarding_welcome_step.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.55, 1.0],
              colors: [AppColors.caramelLight, AppColors.appBackground, AppColors.appBackground],
            ),
          ),
          child: SafeArea(
            child: Consumer<OnboardingController>(
              builder: (context, controller, _) {
                final step = controller.step;
                final showBack = step >= 1 && step <= 3;
                final showDots = step >= 1 && step <= 3;

                return Column(
                  children: [
                    // Top navigation row
                    SizedBox(
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            if (showBack) AppBackButton(onTap: controller.previousStep) else const SizedBox(width: 40),
                            const Spacer(),
                            if (showDots) OnboardingProgressDots(activeIndex: step - 1, total: 3),
                            const Spacer(),
                            const SizedBox(width: 40),
                          ],
                        ),
                      ),
                    ),

                    // Step content — vertically centred
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

                    // CTA area
                    Padding(padding: const EdgeInsets.fromLTRB(24, 8, 24, 24), child: _buildCta(context, controller, step)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCta(BuildContext context, OnboardingController controller, int step) {
    return switch (step) {
      0 => AppButton(text: 'Get started', onTap: controller.nextStep),
      1 => AppButton(text: 'Continue', isEnabled: controller.canContinue, onTap: controller.canContinue ? controller.nextStep : null),
      2 => AppButton(text: 'Continue', onTap: controller.nextStep),
      3 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(text: 'Continue', onTap: controller.nextStep),
          const Gap(4),
          TextButton(onPressed: controller.nextStep, child: Text('Skip for now', style: AppFonts.ctaTertiary.apply(color: AppColors.stone))),
        ],
      ),
      4 => AppButton(
        text: controller.catName.isNotEmpty ? 'Start with ${controller.catName}' : 'Start exploring',
        onTap: () => context.go(RoutePaths.home),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

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
        children: [SizedBox(height: MediaQuery.of(context).size.height * 0.06), _buildStepWidget(), const SizedBox(height: 80)],
      ),
    );
  }

  Widget _buildStepWidget() {
    return switch (step) {
      0 => const OnboardingWelcomeStep(),
      1 => OnboardingNameStep(initialName: controller.catName, onChanged: controller.updateCatName),
      2 => OnboardingAgeStep(catName: controller.catName, initialAgeIndex: controller.catAge, onChanged: controller.updateCatAge),
      3 => OnboardingPhotoStep(catName: controller.catName, photo: controller.catPhoto, onPhotoSelected: controller.updateCatPhoto),
      4 => OnboardingCompleteStep(catName: controller.catName),
      _ => const SizedBox.shrink(),
    };
  }
}
