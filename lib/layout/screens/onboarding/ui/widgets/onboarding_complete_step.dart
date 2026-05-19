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
    required this.catAgeYears,
    required this.catAgeMonths,
    required this.catSex,
    required this.catLifestyle,
    required this.catConditions,
  });

  final String catName;
  final XFile? catPhoto;
  final String catBreed;
  final int catAgeYears;
  final int catAgeMonths;
  final String catSex;
  final String catLifestyle;
  final List<String> catConditions;

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    final breedAsset = catBreed.isNotEmpty ? _breedAssetPath(catBreed) : _fallbackBreedAsset;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cat photo
        catPhoto != null
            ? _CatPhotoCircle(child: Image.file(File(catPhoto!.path), fit: BoxFit.cover))
            : _CatPhotoCircle(child: Image.asset(breedAsset, fit: BoxFit.cover)),
        const Gap(20),

        Text(
          'You\'re all set!',
          style: AppFonts.displayM.apply(color: AppColors.ink),
          textAlign: TextAlign.center,
        ),
        const Gap(6),
        Text(
          '$displayName\'s care profile is ready.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
          textAlign: TextAlign.center,
        ),

        const Gap(24),

        _PremiumProfileCard(
          catName: catName,
          catAgeYears: catAgeYears,
          catAgeMonths: catAgeMonths,
          catSex: catSex,
          catBreed: catBreed,
          catLifestyle: catLifestyle,
          catConditions: catConditions,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Premium profile card
// ─────────────────────────────────────────────

class _PremiumProfileCard extends StatelessWidget {
  const _PremiumProfileCard({
    required this.catName,
    required this.catAgeYears,
    required this.catAgeMonths,
    required this.catSex,
    required this.catBreed,
    required this.catLifestyle,
    required this.catConditions,
  });

  final String catName;
  final int catAgeYears;
  final int catAgeMonths;
  final String catSex;
  final String catBreed;
  final String catLifestyle;
  final List<String> catConditions;

  String get _ageLabel {
    final parts = <String>[];
    if (catAgeYears > 0) parts.add('$catAgeYears yr${catAgeYears == 1 ? '' : 's'}');
    if (catAgeMonths > 0) parts.add('$catAgeMonths mo');
    return parts.isEmpty ? '—' : parts.join(', ');
  }

  String _lifestyleEmoji(String v) => switch (v) {
        'Indoor' => '🏠',
        'Outdoor' => '🌿',
        'Mixed' => '↔️',
        _ => '🏠',
      };

  String _sexEmoji(String v) => v == 'Female' ? '♀' : '♂';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.14),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient accent stripe
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.lavenderDeep, AppColors.caramel],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                if (catName.isNotEmpty) ...[
                  Row(
                    children: [
                      const Text('🐱', style: TextStyle(fontSize: 14)),
                      const Gap(6),
                      Text(
                        catName,
                        style: AppFonts.h2.apply(color: AppColors.ink),
                      ),
                    ],
                  ),
                  const Gap(14),
                ],

                // Stat chips row 1: Age + Sex
                Row(
                  children: [
                    _StatChip(emoji: '📅', label: 'Age', value: _ageLabel),
                    const Gap(8),
                    if (catSex.isNotEmpty)
                      _StatChip(emoji: _sexEmoji(catSex), label: 'Sex', value: catSex)
                    else
                      const _StatChip(emoji: '—', label: 'Sex', value: '—'),
                  ],
                ),
                const Gap(8),

                // Stat chips row 2: Breed + Lifestyle
                Row(
                  children: [
                    _StatChip(
                      emoji: '🐾',
                      label: 'Breed',
                      value: catBreed.isNotEmpty ? catBreed : '—',
                    ),
                    const Gap(8),
                    _StatChip(
                      emoji: catLifestyle.isNotEmpty ? _lifestyleEmoji(catLifestyle) : '—',
                      label: 'Lifestyle',
                      value: catLifestyle.isNotEmpty ? catLifestyle : '—',
                    ),
                  ],
                ),

                // Conditions chips
                if (catConditions.isNotEmpty) ...[
                  const Gap(14),
                  Row(
                    children: [
                      const Text('💊', style: TextStyle(fontSize: 13)),
                      const Gap(6),
                      Text('Conditions', style: AppFonts.captionM.apply(color: AppColors.stone)),
                    ],
                  ),
                  const Gap(8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: catConditions
                        .map(
                          (c) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.lavenderWash,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.lavenderLight),
                            ),
                            child: Text(
                              c,
                              style: AppFonts.captionM.apply(color: AppColors.lavenderDeep),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.emoji, required this.label, required this.value});

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: AppColors.lavenderWash,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 13)),
                const Gap(5),
                Text(label, style: AppFonts.captionM.apply(color: AppColors.stone)),
              ],
            ),
            const Gap(5),
            Text(
              value,
              style: AppFonts.bodyS.copyWith(
                color: AppColors.charcoal,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Cat photo circle
// ─────────────────────────────────────────────

class _CatPhotoCircle extends StatelessWidget {
  const _CatPhotoCircle({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.appWhite, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(child: child),
    );
  }
}
