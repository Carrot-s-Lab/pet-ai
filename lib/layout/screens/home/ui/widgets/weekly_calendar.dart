import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({
    super.key,
    required this.weekDays,
    required this.today,
    required this.selectedDate,
    required this.onDaySelected,
  });

  final List<DateTime> weekDays;
  final DateTime today;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final weekdayFormat = DateFormat.E();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mist),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (final day in weekDays)
                Expanded(
                  child: Center(
                    child: Text(
                      weekdayFormat.format(day).toUpperCase(),
                      style: AppFonts.captionM.apply(color: AppColors.stone),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final day in weekDays)
                Expanded(
                  child: _DayCell(
                    day: day,
                    isToday: _isSameDay(day, today),
                    isSelected: selectedDate != null && _isSameDay(day, selectedDate!),
                    onTap: () => onDaySelected(day),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime day;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color textColor;
    final TextStyle textStyle;

    if (isSelected) {
      background = AppColors.lavenderDeep;
      textColor = AppColors.appWhite;
      textStyle = AppFonts.captionL;
    } else if (isToday) {
      background = AppColors.lavenderLight;
      textColor = AppColors.lavenderDeep;
      textStyle = AppFonts.captionL;
    } else {
      background = Colors.transparent;
      textColor = AppColors.ink;
      textStyle = AppFonts.captionM;
    }

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: textStyle.apply(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
