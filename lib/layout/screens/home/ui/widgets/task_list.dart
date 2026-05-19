import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

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
  });

  final List<Task> tasks;
  final DateTime day;
  final bool loading;
  final ValueChanged<Task> onToggle;
  final ValueChanged<Task> onLongPressTask;
  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildBody(),
          ),
          const SizedBox(height: 12),
          _AddTaskButton(onTap: onAddTask),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (loading && tasks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (tasks.isEmpty) {
      return const _EmptyState();
    }
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 1,
        color: AppColors.borderPrimary,
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
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available,
              size: 56,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 12),
            Text(
              'No tasks for this day',
              style: AppFonts.f14r.apply(color: AppColors.textTertiary),
            ),
          ],
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
    return Material(
      color: AppColors.surfacePrimary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderPrimary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 20, color: AppColors.primaryColor),
              const SizedBox(width: 6),
              Text(
                'Add task',
                style: AppFonts.f14s.apply(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
