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
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceTertiary,
            border: Border(
              bottom: BorderSide(color: AppColors.borderPrimary),
            ),
          ),
          child: Row(
            children: [
              _Avatar(url: cat.photoUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cat.name,
                      style: AppFonts.f16s,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cat.formattedAge,
                      style: AppFonts.f12r.apply(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
              ),
            ],
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
    const size = 56.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfacePrimary,
        border: Border.all(color: AppColors.borderPrimary),
      ),
      clipBehavior: Clip.antiAlias,
      child: url.isEmpty
          ? Icon(Icons.pets, color: AppColors.textTertiary)
          : BaseCachedNetworkImage(
              url,
              useAbsoluteUrl: true,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
    );
  }
}
