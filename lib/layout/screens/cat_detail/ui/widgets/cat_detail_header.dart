import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/cached_network_image/cached_network_image.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class CatDetailHeader extends StatelessWidget {
  const CatDetailHeader({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    const size = 120.0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: AppColors.surfaceTertiary,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfacePrimary,
              border: Border.all(color: AppColors.borderPrimary, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: cat.photoUrl.isEmpty
                ? Icon(Icons.pets, color: AppColors.textTertiary, size: 48)
                : BaseCachedNetworkImage(
                    cat.photoUrl,
                    useAbsoluteUrl: true,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            cat.name,
            style: AppFonts.f20b,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            cat.formattedAge,
            style: AppFonts.f14r.apply(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
