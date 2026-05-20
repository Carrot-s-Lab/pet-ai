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

  String _sexEmoji(String v) => v == 'Female' ? '♀️' : '♂️';

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

        // 2-column grid for Age, Sex, Breed, Lifestyle
        Row(
          children: [
            Expanded(
              child: _FieldCard(
                emoji: '📅',
                label: 'Age',
                value: _ageLabel,
              ),
            ),
            const Gap(10),
            Expanded(
              child: _FieldCard(
                emoji: catSex.isNotEmpty ? _sexEmoji(catSex) : '—',
                label: 'Sex',
                value: catSex.isNotEmpty ? catSex : '—',
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: _FieldCard(
                emoji: '🐾',
                label: 'Breed',
                value: catBreed.isNotEmpty ? catBreed : '—',
              ),
            ),
            const Gap(10),
            Expanded(
              child: _FieldCard(
                emoji: catLifestyle.isNotEmpty ? _lifestyleEmoji(catLifestyle) : '—',
                label: 'Lifestyle',
                value: catLifestyle.isNotEmpty ? catLifestyle : '—',
              ),
            ),
          ],
        ),
        if (catConditions.isNotEmpty) ...[
          const Gap(10),
          _ConditionsCard(conditions: catConditions),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Individual field card
// ─────────────────────────────────────────────

class _FieldCard extends StatelessWidget {
  const _FieldCard({
    required this.emoji,
    required this.label,
    required this.value,
  });

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const Gap(6),
              Text(label, style: AppFonts.captionM.apply(color: AppColors.stone)),
            ],
          ),
          const Gap(6),
          Text(
            value,
            style: AppFonts.bodyM.apply(color: AppColors.ink).copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Conditions card (full-width)
// ─────────────────────────────────────────────

class _ConditionsCard extends StatelessWidget {
  const _ConditionsCard({required this.conditions});

  final List<String> conditions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💊', style: TextStyle(fontSize: 16)),
              const Gap(6),
              Text('Conditions', style: AppFonts.captionM.apply(color: AppColors.stone)),
            ],
          ),
          const Gap(10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: conditions
                .map(
                  (c) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.lavenderWash,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.lavenderLight),
                    ),
                    child: Text(c, style: AppFonts.captionM.apply(color: AppColors.lavenderDeep)),
                  ),
                )
                .toList(),
          ),
        ],
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
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.appWhite, width: 5),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderDeep.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(child: child),
    );
  }
}
