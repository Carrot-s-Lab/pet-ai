import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.weightKg,
    required this.checkIns,
    required this.lastVetVisit,
  });

  final double weightKg;
  final int checkIns;
  final String lastVetVisit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            value: weightKg.toString(),
            unit: 'kg',
            label: 'Current weight',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatChip(value: checkIns.toString(), label: 'Check-ins'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatChip(
            value: lastVetVisit,
            label: 'Last vet visit',
            smallValue: true,
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.value,
    required this.label,
    this.unit,
    this.smallValue = false,
  });

  final String value;
  final String? unit;
  final String label;
  final bool smallValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 9),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: smallValue
                    ? AppFonts.f14s.apply(color: AppColors.ink)
                    : AppFonts.f18b.apply(color: AppColors.ink),
              ),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Text(
                  unit!,
                  style: AppFonts.captionM.apply(color: AppColors.stone),
                ),
              ],
            ],
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppFonts.captionS.apply(color: AppColors.stone),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
