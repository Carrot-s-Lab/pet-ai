import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

const _presets = [
  (label: 'Feed', icon: Icons.restaurant_rounded, color: AppColors.caramel, isPremium: false),
  (label: 'Play', icon: Icons.sports_esports_rounded, color: AppColors.wellness, isPremium: false),
  (label: 'Brush', icon: Icons.auto_fix_high_rounded, color: AppColors.info, isPremium: false),
  (label: 'Custom', icon: Icons.add_circle_outline_rounded, color: AppColors.lavenderDeep, isPremium: true),
];

class TaskQuickAddGrid extends StatelessWidget {
  const TaskQuickAddGrid({
    super.key,
    required this.onAddPreset,
    required this.onCustomTap,
  });

  final void Function(String title) onAddPreset;
  final VoidCallback onCustomTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick add',
          style: AppFonts.captionL.apply(color: AppColors.stone),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.6,
          children: [
            for (final p in _presets)
              _PresetCard(
                label: p.label,
                icon: p.icon,
                color: p.color,
                isPremium: p.isPremium,
                onTap: p.isPremium ? onCustomTap : () => onAddPreset(p.label),
              ),
          ],
        ),
      ],
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.isPremium,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool isPremium;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isPremium
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.lavenderLight, AppColors.lavenderWash],
                )
              : null,
          color: isPremium ? null : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPremium ? AppColors.lavender : AppColors.mist,
            width: isPremium ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 28, color: color),
                  const Spacer(),
                  Text(
                    label,
                    style: AppFonts.captionL.apply(color: AppColors.ink),
                  ),
                ],
              ),
            ),
            if (isPremium)
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 16,
                  color: AppColors.lavenderDeep,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
