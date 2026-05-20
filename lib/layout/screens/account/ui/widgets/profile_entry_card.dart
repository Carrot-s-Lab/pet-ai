import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

enum EntryCardBadgeStyle { ok, due, overdue, none }

class ProfileEntryCard extends StatelessWidget {
  const ProfileEntryCard({
    super.key,
    required this.iconEmoji,
    required this.iconBgColor,
    required this.title,
    this.subtitle,
    this.badgeLabel,
    this.badgeStyle = EntryCardBadgeStyle.none,
    this.trailingText,
    this.showDueDot = false,
    this.dimmed = false,
    this.onTap,
  });

  final String iconEmoji;
  final Color iconBgColor;
  final String title;
  final String? subtitle;
  final String? badgeLabel;
  final EntryCardBadgeStyle badgeStyle;
  final String? trailingText;
  final bool showDueDot;
  final bool dimmed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dimmed ? 0.55 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          margin: const EdgeInsets.only(bottom: 9),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x121A1611),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Color(0x0A1A1611),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(iconEmoji, style: const TextStyle(fontSize: 19)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.bodyM.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle!,
                        style: AppFonts.bodyS.apply(color: AppColors.stone),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showDueDot)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: const BoxDecoration(
                        color: AppColors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (badgeLabel != null)
                    _EntryBadge(label: badgeLabel!, style: badgeStyle),
                  if (trailingText != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      trailingText!,
                      style: AppFonts.captionM.apply(color: AppColors.pebble),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryBadge extends StatelessWidget {
  const _EntryBadge({required this.label, required this.style});

  final String label;
  final EntryCardBadgeStyle style;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    switch (style) {
      case EntryCardBadgeStyle.ok:
        bg = AppColors.wellness.withValues(alpha: 0.13);
        fg = AppColors.wellness;
      case EntryCardBadgeStyle.due:
        bg = AppColors.amber.withValues(alpha: 0.13);
        fg = AppColors.caramelDeep;
      case EntryCardBadgeStyle.overdue:
        bg = AppColors.urgent.withValues(alpha: 0.10);
        fg = AppColors.urgent;
      case EntryCardBadgeStyle.none:
        bg = AppColors.cloud;
        fg = AppColors.stone;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppFonts.captionS.copyWith(fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
