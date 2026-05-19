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
        ? AppFonts.f14r.apply(
            color: AppColors.textTertiary,
            decoration: TextDecoration.lineThrough,
          )
        : AppFonts.f14m.apply(color: AppColors.textPrimary);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
        color: completed ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: completed ? AppColors.primaryColor : AppColors.borderPrimary,
          width: 1.5,
        ),
      ),
      child: completed
          ? const Icon(Icons.check, size: 16, color: AppColors.white)
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
        color: AppColors.selectedSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: AppFonts.f10m.apply(color: AppColors.primaryColor),
      ),
    );
  }
}
