import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/cached_network_image/cached_network_image.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class CatProfileBanner extends StatelessWidget {
  const CatProfileBanner({super.key, required this.cat, required this.onTap});

  final Cat cat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cardSurface, AppColors.lavenderWash],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lavenderLight, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lavender.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _Avatar(url: cat.photoUrl),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          cat.name,
                          style: AppFonts.h2.apply(color: AppColors.ink),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cat.formattedAge,
                          style: AppFonts.bodyS.apply(color: AppColors.stone),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lavenderLight,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.lavenderDeep,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lavenderWash,
        border: Border.all(color: AppColors.lavenderLight, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: url.isEmpty
          ? const Icon(Icons.pets_rounded, color: AppColors.lavenderDeep, size: 32)
          : url.startsWith('http')
              ? BaseCachedNetworkImage(
                  url,
                  useAbsoluteUrl: true,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                )
              : Image.file(
                  File(url),
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                ),
    );
  }
}
