import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import '../../controller/profile_controller.dart';

class ProfileWeightTab extends StatelessWidget {
  const ProfileWeightTab({
    super.key,
    required this.entries,
    required this.currentWeightKg,
  });

  final List<WeightEntry> entries;
  final double currentWeightKg;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _fmtMonth(DateTime d) => _months[d.month - 1];
  String _fmtDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final weights = entries.map((e) => e.weightKg).toList();
    final minDisplay =
        (weights.reduce((a, b) => a < b ? a : b) - 0.3).clamp(0.0, 99.0);
    final maxDisplay = weights.reduce((a, b) => a > b ? a : b) + 0.1;
    final range = maxDisplay - minDisplay;

    double barRatio(double w) =>
        range == 0 ? 0.5 : ((w - minDisplay) / range).clamp(0.1, 1.0);

    final reversed = entries.reversed.toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        children: [
          _ChartCard(
            entries: entries,
            currentWeightKg: currentWeightKg,
            barRatio: barRatio,
            fmtMonth: _fmtMonth,
          ),
          const SizedBox(height: 10),
          _WeightLogCard(
            entries: entries,
            reversed: reversed,
            fmtDate: _fmtDate,
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.entries,
    required this.currentWeightKg,
    required this.barRatio,
    required this.fmtMonth,
  });

  final List<WeightEntry> entries;
  final double currentWeightKg;
  final double Function(double) barRatio;
  final String Function(DateTime) fmtMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight history',
                      style: AppFonts.f14s.apply(color: AppColors.ink),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Last 6 months',
                      style: AppFonts.captionM.apply(color: AppColors.stone),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$currentWeightKg ',
                          style: AppFonts.f20b
                              .apply(color: AppColors.caramelDeep)
                              .copyWith(letterSpacing: -0.5),
                        ),
                        TextSpan(
                          text: 'kg',
                          style: AppFonts.bodyS.apply(color: AppColors.stone),
                        ),
                        TextSpan(
                          text: '  ↑ +0.1',
                          style: AppFonts.captionM
                              .apply(color: AppColors.wellness)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Healthy: 3.5–5.0 kg',
                    style: AppFonts.captionS.apply(color: AppColors.pebble),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 76,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: entries.asMap().entries.map((entry) {
                final i = entry.key;
                final e = entry.value;
                final isCurrent = i == entries.length - 1;
                final barH = barRatio(e.weightKg) * 48;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${e.weightKg}',
                        style: AppFonts.captionS.apply(color: AppColors.stone),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: barH,
                        margin: const EdgeInsets.symmetric(horizontal: 3.5),
                        decoration: BoxDecoration(
                          gradient: isCurrent
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFFE0A55E), AppColors.caramel],
                                )
                              : null,
                          color: isCurrent ? null : AppColors.caramelLight,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fmtMonth(e.date),
                        style: isCurrent
                            ? AppFonts.captionS
                                .apply(color: AppColors.caramelDeep)
                                .copyWith(fontWeight: FontWeight.w700)
                            : AppFonts.captionS.apply(color: AppColors.pebble),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightLogCard extends StatelessWidget {
  const _WeightLogCard({
    required this.entries,
    required this.reversed,
    required this.fmtDate,
  });

  final List<WeightEntry> entries;
  final List<WeightEntry> reversed;
  final String Function(DateTime) fmtDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Color(0x121A1611), blurRadius: 12, offset: Offset(0, 2)),
          BoxShadow(color: Color(0x0A1A1611), blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        children: reversed.asMap().entries.map((entry) {
          final i = entry.key;
          final e = entry.value;
          final isLast = i == reversed.length - 1;
          final originalIdx = entries.indexOf(e);
          double? delta;
          if (originalIdx > 0) {
            delta = e.weightKg - entries[originalIdx - 1].weightKg;
          }

          final deltaStr = delta == null
              ? '—'
              : delta > 0.005
                  ? '+${delta.toStringAsFixed(1)}'
                  : delta < -0.005
                      ? delta.toStringAsFixed(1)
                      : '—';

          final deltaColor = delta == null || delta.abs() < 0.005
              ? AppColors.pebble
              : delta > 0
                  ? AppColors.amber
                  : AppColors.wellness;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : const Border(bottom: BorderSide(color: AppColors.mist)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fmtDate(e.date),
                    style: AppFonts.bodyS.apply(color: AppColors.stone),
                  ),
                ),
                Text(
                  '${e.weightKg} kg',
                  style: AppFonts.bodyM.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: Text(
                    deltaStr,
                    style: AppFonts.captionM
                        .apply(color: deltaColor)
                        .copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
