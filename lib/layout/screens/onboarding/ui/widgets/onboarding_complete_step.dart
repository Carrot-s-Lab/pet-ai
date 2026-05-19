import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';


const _fallbackBreedAsset = 'assets/images/cat_breed_ragdoll.png';

String _breedAssetPath(String breed) {
  final slug = breed.toLowerCase().replaceAll(' / ', '_').replaceAll('/', '_').replaceAll(' ', '_');
  return 'assets/images/cat_breed_$slug.png';
}

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
    final breedAsset = catBreed.isNotEmpty ? _breedAssetPath(catBreed) : _fallbackBreedAsset;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        catPhoto != null
            ? _CatPhotoCircle(child: Image.file(File(catPhoto!.path), fit: BoxFit.cover))
            : _CatPhotoCircle(child: Image.asset(breedAsset, fit: BoxFit.cover)),
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
  const _CatPhotoCircle({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
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
      child: ClipOval(child: child),
    );
  }
}
