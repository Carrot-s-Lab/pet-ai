import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import 'task_quick_add_grid.dart';
import 'task_row.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.day,
    required this.loading,
    required this.onToggle,
    required this.onLongPressTask,
    required this.onAddTask,
    required this.onAddPreset,
  });

  final List<Task> tasks;
  final DateTime day;
  final bool loading;
  final ValueChanged<Task> onToggle;
  final ValueChanged<Task> onLongPressTask;
  final VoidCallback onAddTask;
  final Future<void> Function(String title) onAddPreset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildBody(context),
          ),
          const SizedBox(height: 12),
          _AddTaskButton(onTap: onAddTask),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (loading && tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.lavenderDeep),
        ),
      );
    }
    if (tasks.isEmpty) {
      return SingleChildScrollView(
        child: TaskQuickAddGrid(
          onAddPreset: onAddPreset,
          onCustomTap: () {},
        ),
      );
    }
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (_, _) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.mist,
          ),
          itemBuilder: (_, i) {
            final task = tasks[i];
            return TaskRow(
              task: task,
              completed: task.isCompletedOn(day),
              onToggle: () => onToggle(task),
              onLongPress: () => onLongPressTask(task),
            );
          },
        ),
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.caramel, AppColors.caramelDeep],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.caramel.withValues(alpha: 0.38),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_rounded, size: 20, color: AppColors.appWhite),
            const SizedBox(width: 6),
            Text(
              'Add task',
              style: AppFonts.ctaSecondary.apply(color: AppColors.appWhite),
            ),
          ],
        ),
      ),
    );
  }
}
