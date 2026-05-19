import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatLimitBanner extends StatelessWidget {
  const ChatLimitBanner({super.key, required this.onUpgrade});

  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.caramelLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.caramel.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/pixel_cat.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You\'ve used your free message',
            style: AppFonts.h3.apply(color: AppColors.ink),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Upgrade to Premium for unlimited conversations with Catti — anytime, for any question.',
            style: AppFonts.bodyS.apply(color: AppColors.stone),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const _FeatureRow(icon: Icons.all_inclusive_rounded, label: 'Unlimited messages'),
          const SizedBox(height: 8),
          const _FeatureRow(icon: Icons.add_photo_alternate_outlined, label: 'Photo analysis'),
          const SizedBox(height: 8),
          const _FeatureRow(icon: Icons.history_rounded, label: 'Full chat history'),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onUpgrade,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.caramel, AppColors.caramelDeep],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.caramel.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Upgrade to Premium',
                style: AppFonts.ctaPrimary.apply(color: AppColors.appWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.caramelWash,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: AppColors.caramel),
        ),
        const SizedBox(width: 12),
        Text(label, style: AppFonts.bodyS.apply(color: AppColors.charcoal)),
      ],
    );
  }
}
