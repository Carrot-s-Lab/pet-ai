import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/buttons/app_button.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class SessionEmptyState extends StatelessWidget {
  const SessionEmptyState({super.key, required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.caramelWash,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.caramel.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 38,
                color: AppColors.caramel,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cat\'s health story starts here',
              style: AppFonts.h2.apply(color: AppColors.ink),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Ask questions, describe symptoms, or upload a photo — PurrCheck AI will help.',
              style: AppFonts.bodyM.apply(color: AppColors.stone),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Start a conversation',
              onTap: onCreate,
              height: 52,
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_rounded, color: AppColors.appWhite, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Start a conversation',
                    style: AppFonts.ctaPrimary.apply(color: AppColors.appWhite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
