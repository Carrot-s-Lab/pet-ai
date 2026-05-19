import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class SessionEmptyState extends StatelessWidget {
  const SessionEmptyState({super.key, required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Where would you like to start?',
              style: AppFonts.h3.apply(color: AppColors.ink),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Pick a topic or start a free conversation.',
              style: AppFonts.bodyS.apply(color: AppColors.stone),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _QuickStartCard(
              icon: Icons.health_and_safety_outlined,
              title: 'Symptom check',
              subtitle: 'Describe what you\'re seeing — I\'ll help figure it out.',
              color: AppColors.wellness,
              onTap: onCreate,
            ),
            const SizedBox(height: 12),
            _QuickStartCard(
              icon: Icons.restaurant_outlined,
              title: 'Diet advice',
              subtitle: 'Food questions, treats, allergies, and feeding schedules.',
              color: AppColors.caramel,
              onTap: onCreate,
            ),
            const SizedBox(height: 12),
            _QuickStartCard(
              icon: Icons.psychology_outlined,
              title: 'Behaviour question',
              subtitle: 'Scratching, hiding, aggression, litter habits — let\'s talk.',
              color: AppColors.lavenderDeep,
              onTap: onCreate,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStartCard extends StatelessWidget {
  const _QuickStartCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A1611).withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppFonts.h4.apply(color: AppColors.ink)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppFonts.bodyS.apply(color: AppColors.stone),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: color.withValues(alpha: 0.6), size: 20),
          ],
        ),
      ),
    );
  }
}
