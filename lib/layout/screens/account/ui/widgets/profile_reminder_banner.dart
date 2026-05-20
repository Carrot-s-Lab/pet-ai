import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ProfileReminderBanner extends StatefulWidget {
  const ProfileReminderBanner({
    super.key,
    required this.message,
    this.icon = '🔔',
  });

  final String message;
  final String icon;

  @override
  State<ProfileReminderBanner> createState() => _ProfileReminderBannerState();
}

class _ProfileReminderBannerState extends State<ProfileReminderBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(14, 11, 8, 11),
      decoration: BoxDecoration(
        color: AppColors.amber.withValues(alpha: 0.10),
        border: Border.all(color: AppColors.amber.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.icon, style: const TextStyle(fontSize: 17)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.message,
              style: AppFonts.bodyS.apply(color: AppColors.charcoal),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _dismissed = true),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                '×',
                style: AppFonts.f18r.apply(color: AppColors.pebble),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
