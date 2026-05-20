import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/cached_network_image/cached_network_image.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({
    super.key,
    required this.cat,
    required this.lifestyle,
    required this.onEditTap,
  });

  final Cat cat;
  final String lifestyle;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final sexSymbol = cat.sex.toLowerCase() == 'female' ? '♀' : '♂';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _CatAvatar(photoUrl: cat.photoUrl),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat.name, style: AppFonts.h1.apply(color: AppColors.ink)),
                const SizedBox(height: 4),
                Text(
                  '${cat.breed} · ${cat.formattedAge} · $sexSymbol',
                  style: AppFonts.bodyS.apply(color: AppColors.stone),
                ),
                const SizedBox(height: 10),
                _EditButton(onTap: onEditTap),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CatAvatar extends StatelessWidget {
  const _CatAvatar({required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    const size = 86.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.lavenderLight, AppColors.lavenderDeep],
        ),
        border: Border.all(color: AppColors.appWhite, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: photoUrl.isEmpty
            ? const Center(child: Text('🐱', style: TextStyle(fontSize: 40)))
            : photoUrl.startsWith('http')
                ? BaseCachedNetworkImage(
                    photoUrl,
                    useAbsoluteUrl: true,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  )
                : Image.file(
                    File(photoUrl),
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lavenderDeep, width: 1.5),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit_outlined, size: 12, color: AppColors.lavenderDeep),
            const SizedBox(width: 5),
            Text(
              'Edit profile',
              style: AppFonts.captionL.apply(color: AppColors.lavenderDeep),
            ),
          ],
        ),
      ),
    );
  }
}
