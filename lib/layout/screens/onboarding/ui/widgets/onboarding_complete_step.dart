import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingCompleteStep extends StatelessWidget {
  const OnboardingCompleteStep({
    super.key,
    required this.catName,
    required this.catPhoto,
    required this.catBreed,
  });

  final String catName;
  final XFile? catPhoto;
  final String catBreed;

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cat photo or SVG illustration
        catPhoto != null
            ? _CatPhotoCircle(photo: catPhoto!)
            : SvgPicture.asset(
                'assets/images/cat_onboarding_complete.svg',
                height: 180,
                fit: BoxFit.contain,
              ),
        const Gap(16),

        // Breed chip (shown when no photo, gives context; always shown when breed is set)
        if (catBreed.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lavenderWash,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lavenderLight),
            ),
            child: Text(catBreed, style: AppFonts.captionL.apply(color: AppColors.lavenderDeep)),
          ),

        const Gap(28),
        Text(
          'You\'re all set!',
          style: AppFonts.displayM.apply(color: AppColors.ink),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          '$displayName\'s care companion is ready.',
          style: AppFonts.bodyL.apply(color: AppColors.lavenderDeep),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CatPhotoCircle extends StatelessWidget {
  const _CatPhotoCircle({required this.photo});

  final XFile photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.lavenderLight, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.file(
          File(photo.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
