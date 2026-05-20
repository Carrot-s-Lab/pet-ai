import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ProfileAddSheet extends StatelessWidget {
  const ProfileAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        emoji: '💉',
        bgColor: AppColors.wellness.withValues(alpha: 0.13),
        label: 'Vaccine',
        desc: 'Log a new or upcoming vaccination',
      ),
      (
        emoji: '💊',
        bgColor: AppColors.amber.withValues(alpha: 0.13),
        label: 'Medication',
        desc: 'Add or update a medication',
      ),
      (
        emoji: '⚖️',
        bgColor: AppColors.lavenderDeep.withValues(alpha: 0.13),
        label: 'Weight reading',
        desc: 'Log today\'s weight',
      ),
      (
        emoji: '🏥',
        bgColor: AppColors.info.withValues(alpha: 0.13),
        label: 'Vet visit',
        desc: 'Record a visit or appointment',
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 44),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.mist,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Add to record', style: AppFonts.h2.apply(color: AppColors.ink)),
          const SizedBox(height: 4),
          ...options.asMap().entries.map((entry) {
            final i = entry.key;
            final o = entry.value;
            return _SheetOption(
              emoji: o.emoji,
              bgColor: o.bgColor,
              label: o.label,
              desc: o.desc,
              isLast: i == options.length - 1,
              onTap: () => Navigator.pop(context),
            );
          }),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  const _SheetOption({
    required this.emoji,
    required this.bgColor,
    required this.label,
    required this.desc,
    required this.isLast,
    required this.onTap,
  });

  final String emoji;
  final Color bgColor;
  final String label;
  final String desc;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.mist)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppFonts.h4.apply(color: AppColors.ink)),
                  const SizedBox(height: 2),
                  Text(desc, style: AppFonts.bodyS.apply(color: AppColors.stone)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.pebble, size: 20),
          ],
        ),
      ),
    );
  }
}
