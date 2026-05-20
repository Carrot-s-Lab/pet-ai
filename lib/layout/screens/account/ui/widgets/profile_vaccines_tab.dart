import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import '../../controller/profile_controller.dart';
import 'profile_entry_card.dart';
import 'profile_reminder_banner.dart';
import 'profile_section_label.dart';

class ProfileVaccinesTab extends StatelessWidget {
  const ProfileVaccinesTab({super.key, required this.vaccines});

  final List<VaccineEntry> vaccines;

  @override
  Widget build(BuildContext context) {
    final upToDate =
        vaccines.where((v) => v.status == VaccineStatus.upToDate).toList();
    final dueSoon =
        vaccines.where((v) => v.status == VaccineStatus.dueSoon).toList();
    final optional =
        vaccines.where((v) => v.status == VaccineStatus.optional).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dueSoon.isNotEmpty)
            const ProfileReminderBanner(
              message:
                  'FVRCP booster due in 8 months — schedule before Jan 15',
            ),
          if (upToDate.isNotEmpty) ...[
            const ProfileSectionLabel('Up to date'),
            ...upToDate.map(
              (v) => ProfileEntryCard(
                iconEmoji: '💉',
                iconBgColor: AppColors.wellness.withValues(alpha: 0.13),
                title: v.name,
                badgeLabel: 'Up to date',
                badgeStyle: EntryCardBadgeStyle.ok,
                trailingText: 'Due ${v.nextDue}',
              ),
            ),
          ],
          if (dueSoon.isNotEmpty) ...[
            const ProfileSectionLabel('Due soon'),
            ...dueSoon.map(
              (v) => ProfileEntryCard(
                iconEmoji: '💉',
                iconBgColor: AppColors.amber.withValues(alpha: 0.13),
                title: v.name,
                badgeLabel: 'Due ${v.nextDue}',
                badgeStyle: EntryCardBadgeStyle.due,
                showDueDot: true,
              ),
            ),
          ],
          if (optional.isNotEmpty) ...[
            const ProfileSectionLabel('Optional / Ask vet'),
            ...optional.map(
              (v) => ProfileEntryCard(
                iconEmoji: '💊',
                iconBgColor: AppColors.cloud,
                title: v.name,
                trailingText: 'Ask vet',
                dimmed: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
