import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key,
    required this.task,
    required this.completed,
    required this.onToggle,
    required this.onLongPress,
  });

  final Task task;
  final bool completed;
  final VoidCallback onToggle;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final titleStyle = completed
        ? AppFonts.bodyS.apply(
            color: AppColors.pebble,
            decoration: TextDecoration.lineThrough,
          )
        : AppFonts.bodyS.apply(color: AppColors.ink);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              _Checkbox(completed: completed),
              const SizedBox(width: 12),
              Expanded(child: Text(task.title, style: titleStyle)),
              if (task.type == TaskType.daily) const _TypeBadge(text: 'Daily'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: completed
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.lavenderDeep, AppColors.lavender],
              )
            : null,
        color: completed ? null : Colors.transparent,
        border: completed
            ? null
            : Border.all(color: AppColors.mist, width: 1.5),
      ),
      child: completed
          ? const Icon(Icons.check_rounded, size: 15, color: AppColors.appWhite)
          : null,
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.lavenderWash,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lavenderLight),
      ),
      child: Text(
        text,
        style: AppFonts.captionS.apply(color: AppColors.lavenderDeep),
      ),
    );
  }
}
