import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import '../../controller/profile_controller.dart';
import 'profile_reminder_banner.dart';
import 'profile_section_label.dart';

class ProfileVetVisitsTab extends StatelessWidget {
  const ProfileVetVisitsTab({super.key, required this.visits});

  final List<VetVisitEntry> visits;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _fmtDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  @override
  Widget build(BuildContext context) {
    final upcoming = visits.where((v) => v.isUpcoming).toList();
    final past = visits.where((v) => !v.isUpcoming).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (upcoming.isNotEmpty)
            const ProfileReminderBanner(
              icon: '📅',
              message:
                  'Dental cleaning in 18 days — Jun 5 at City Cat Clinic. No food 12h before.',
            ),
          if (upcoming.isNotEmpty) ...[
            const ProfileSectionLabel('Upcoming'),
            ...upcoming.map(
              (v) => _VetCard(
                visit: v,
                dateStr: _fmtDate(v.date),
                isUpcoming: true,
              ),
            ),
          ],
          if (past.isNotEmpty) ...[
            const ProfileSectionLabel('Past visits'),
            ...past.map(
              (v) => _VetCard(
                visit: v,
                dateStr: _fmtDate(v.date),
                isUpcoming: false,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _VetCard extends StatelessWidget {
  const _VetCard({
    required this.visit,
    required this.dateStr,
    required this.isUpcoming,
  });

  final VetVisitEntry visit;
  final String dateStr;
  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Color(0x121A1611), blurRadius: 12, offset: Offset(0, 2)),
          BoxShadow(color: Color(0x0A1A1611), blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  visit.type,
                  style: AppFonts.bodyM.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _DateBadge(dateStr: dateStr, isUpcoming: isUpcoming),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            visit.notes,
            style: AppFonts.bodyS.apply(color: AppColors.stone),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.mist, height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('🏥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${visit.clinic} · ${visit.vetName}',
                  style: AppFonts.bodyS.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.dateStr, required this.isUpcoming});

  final String dateStr;
  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: isUpcoming
            ? AppColors.amber.withValues(alpha: 0.13)
            : AppColors.wellness.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        dateStr,
        style: AppFonts.captionS.copyWith(
          fontWeight: FontWeight.w600,
          color: isUpcoming ? AppColors.caramelDeep : AppColors.wellness,
        ),
      ),
    );
  }
}
