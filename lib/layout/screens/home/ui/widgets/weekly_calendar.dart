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
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              for (final day in weekDays)
                Expanded(
                  child: Center(
                    child: Text(
                      weekdayFormat.format(day).toUpperCase(),
                      style: AppFonts.f12m.apply(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              for (final day in weekDays)
                Expanded(
                  child: _DayCell(
                    day: day,
                    isToday: _isSameDay(day, today),
                    isSelected:
                        selectedDate != null && _isSameDay(day, selectedDate!),
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
      background = AppColors.primaryColor;
      textColor = AppColors.white;
      textStyle = AppFonts.f14s;
    } else if (isToday) {
      background = AppColors.selectedSurface;
      textColor = AppColors.primaryColor;
      textStyle = AppFonts.f14s;
    } else {
      background = Colors.transparent;
      textColor = AppColors.textPrimary;
      textStyle = AppFonts.f14r;
    }

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
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
