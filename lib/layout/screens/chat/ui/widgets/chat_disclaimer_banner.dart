import 'package:flutter/material.dart';
import 'package:pet_ai_project/core/extensions/context.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatDisclaimerBanner extends StatelessWidget {
  const ChatDisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.surfaceTertiary,
      child: Text(
        context.tr.chatDisclaimer,
        textAlign: TextAlign.center,
        style: AppFonts.f12r.apply(color: AppColors.textTertiary),
      ),
    );
  }
}
