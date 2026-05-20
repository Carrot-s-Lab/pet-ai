import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/tip.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class TipBanner extends StatelessWidget {
  const TipBanner({super.key, required this.tip});

  final Tip tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lavenderWash,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lavenderLight),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: AppColors.lavenderDeep, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip.text,
              style: AppFonts.captionL.apply(color: AppColors.charcoal),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
