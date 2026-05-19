import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class TaskSheetResult {
  const TaskSheetResult({
    required this.title,
    required this.type,
    required this.date,
    required this.completed,
  });

  final String title;
  final TaskType type;
  final DateTime? date;
  final bool completed;
}

Future<void> showTaskSheet(
  BuildContext context, {
  required DateTime selectedDate,
  Task? existingTask,
  required Future<void> Function(TaskSheetResult result) onSubmit,
  Future<void> Function()? onDelete,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _TaskSheet(
      selectedDate: selectedDate,
      existingTask: existingTask,
      onSubmit: onSubmit,
      onDelete: onDelete,
    ),
  );
}

class _TaskSheet extends StatefulWidget {
  const _TaskSheet({
    required this.selectedDate,
    required this.existingTask,
    required this.onSubmit,
    required this.onDelete,
  });

  final DateTime selectedDate;
  final Task? existingTask;
  final Future<void> Function(TaskSheetResult result) onSubmit;
  final Future<void> Function()? onDelete;

  @override
  State<_TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<_TaskSheet> {
  late final TextEditingController _controller;
  late TaskType _type;
  late DateTime _date;
  late bool _completed;
  bool _submitting = false;
  bool _deleting = false;

  bool get _isEditing => widget.existingTask != null;

  @override
  void initState() {
    super.initState();
    final t = widget.existingTask;
    _controller = TextEditingController(text: t?.title ?? '');
    _type = t?.type ?? TaskType.daily;
    _date = t?.date ?? widget.selectedDate;
    _completed = t != null && t.isCompletedOn(widget.selectedDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _controller.text.trim().isNotEmpty && !_submitting && !_deleting;

  Future<void> _submit() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    setState(() => _submitting = true);
    try {
      await widget.onSubmit(TaskSheetResult(
        title: title,
        type: _type,
        date: _type == TaskType.normal ? _date : null,
        completed: _completed,
      ));
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _confirmAndDelete() async {
    final onDelete = widget.onDelete;
    if (onDelete == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete task?'),
        content: Text(
          'This will permanently remove "${_controller.text.trim().isEmpty ? "this task" : _controller.text.trim()}".',
          style: AppFonts.f14r.apply(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _deleting = true);
    try {
      await onDelete();
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final dateLabel = DateFormat('EEEE, MMM d').format(_date);
    final selectedDateLabel =
        DateFormat('EEE, MMM d').format(widget.selectedDate);
    final headerText = _isEditing ? 'Edit task' : 'New task';
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, bottomInset + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(headerText, style: AppFonts.f18s),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: !_isEditing,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'What needs to be done?',
              hintStyle: AppFonts.f14r.apply(color: AppColors.textTertiary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Type',
            style: AppFonts.f12m.apply(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _TypeChip(
                  label: 'Daily',
                  description: 'Repeats every day',
                  selected: _type == TaskType.daily,
                  onTap: () => setState(() => _type = TaskType.daily),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TypeChip(
                  label: 'One-off',
                  description: 'For $dateLabel',
                  selected: _type == TaskType.normal,
                  onTap: () => setState(() => _type = TaskType.normal),
                ),
              ),
            ],
          ),
          if (_isEditing) ...[
            const SizedBox(height: 16),
            _DoneToggle(
              label: 'Done for $selectedDateLabel',
              value: _completed,
              onChanged: (v) => setState(() => _completed = v),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _canSubmit ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.borderPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text('Save',
                      style: AppFonts.f14s.apply(color: Colors.white)),
            ),
          ),
          if (_isEditing && widget.onDelete != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _deleting ? null : _confirmAndDelete,
              icon: _deleting
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: AppColors.red,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.delete_outline, color: AppColors.red, size: 20),
              label: Text(
                'Delete task',
                style: AppFonts.f14s.apply(color: AppColors.red),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? AppColors.primaryColor : AppColors.borderPrimary;
    final background =
        selected ? AppColors.selectedSurface : Colors.transparent;
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppFonts.f14s.apply(
                  color: selected
                      ? AppColors.primaryColor
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppFonts.f12r.apply(color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoneToggle extends StatelessWidget {
  const _DoneToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderPrimary),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? AppColors.primaryColor : Colors.transparent,
                  border: Border.all(
                    color: value
                        ? AppColors.primaryColor
                        : AppColors.borderPrimary,
                    width: 1.5,
                  ),
                ),
                child: value
                    ? const Icon(Icons.check, size: 14, color: AppColors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: AppFonts.f14m)),
            ],
          ),
        ),
      ),
    );
  }
}
