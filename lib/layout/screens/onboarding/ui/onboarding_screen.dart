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
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.lavenderLight, AppColors.lavenderWash],
            ),
          ),
          child: SafeArea(
            child: Consumer<OnboardingController>(
              builder: (context, controller, _) {
                final step = controller.step;
                // 0=name, 1=photo, 2=age, 3=sex, 4=breed, 5=conditions, 6=complete
                final showBack = step >= 1 && step <= 5;
                final showDots = step <= 5;

                return Column(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCta(BuildContext context, OnboardingController controller, int step) {
    Widget skipButton() => TextButton(
      onPressed: controller.nextStep,
      child: Text('Skip for now', style: AppFonts.ctaTertiary.apply(color: AppColors.stone)),
    );

    return switch (step) {
      0 => AppButton(text: 'Continue', isEnabled: controller.canContinue, onTap: controller.canContinue ? controller.nextStep : null),
      1 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', onTap: controller.nextStep), const Gap(4), skipButton()],
      ),
      2 => AppButton(text: 'Continue', onTap: controller.nextStep),
      3 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', onTap: controller.nextStep), const Gap(4), skipButton()],
      ),
      4 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', onTap: controller.nextStep), const Gap(4), skipButton()],
      ),
      5 => Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppButton(text: 'Continue', onTap: controller.nextStep), const Gap(4), skipButton()],
      ),
      6 => AppButton(
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
