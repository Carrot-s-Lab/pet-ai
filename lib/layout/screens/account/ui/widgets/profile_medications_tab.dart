import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import '../../controller/profile_controller.dart';
import 'profile_entry_card.dart';
import 'profile_reminder_banner.dart';
import 'profile_section_label.dart';

class ProfileMedicationsTab extends StatelessWidget {
  const ProfileMedicationsTab({super.key, required this.medications});

  final List<MedicationEntry> medications;

  @override
  Widget build(BuildContext context) {
    final active =
        medications.where((m) => m.status != MedicationStatus.completed).toList();
    final past =
        medications.where((m) => m.status == MedicationStatus.completed).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (active.isNotEmpty) ...[
            const ProfileSectionLabel('Active'),
            ...active.expand((m) {
              final isDueSoon = m.status == MedicationStatus.dueSoon;
              return <Widget>[
                ProfileEntryCard(
                  iconEmoji: isDueSoon ? '💊' : '🌿',
                  iconBgColor: isDueSoon
                      ? AppColors.amber.withValues(alpha: 0.13)
                      : AppColors.wellness.withValues(alpha: 0.13),
                  title: m.name,
                  badgeLabel: isDueSoon ? null : m.frequency,
                  badgeStyle: EntryCardBadgeStyle.ok,
                  trailingText: m.nextDue,
                  showDueDot: isDueSoon,
                ),
                if (isDueSoon)
                  const ProfileReminderBanner(
                    message:
                        'Revolution Plus due in 14 days — apply to back of neck',
                  ),
              ];
            }),
          ],
          if (past.isNotEmpty) ...[
            const ProfileSectionLabel('Past / Completed'),
            ...past.map(
              (m) => ProfileEntryCard(
                iconEmoji: '💊',
                iconBgColor: AppColors.cloud,
                title: m.name,
                badgeLabel: 'Done',
                badgeStyle: EntryCardBadgeStyle.ok,
                dimmed: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
