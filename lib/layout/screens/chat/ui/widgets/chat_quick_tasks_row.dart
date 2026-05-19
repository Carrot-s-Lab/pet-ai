import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

const _kTasks = [
  (label: 'Symptom\ncheck', icon: Icons.health_and_safety_outlined),
  (label: 'Is this\nurgent?', icon: Icons.warning_amber_rounded),
  (label: 'Diet\nadvice', icon: Icons.restaurant_outlined),
  (label: 'Behaviour\nquestion', icon: Icons.psychology_outlined),
  (label: 'Vet visit\nprep', icon: Icons.local_hospital_outlined),
  (label: 'Medication\nreminder', icon: Icons.medication_outlined),
];

class ChatQuickTasksRow extends StatelessWidget {
  const ChatQuickTasksRow({super.key, required this.onSelect});

  final void Function(String task) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _kTasks.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => _TaskCard(
          label: _kTasks[index].label,
          icon: _kTasks[index].icon,
          onTap: () => onSelect(_kTasks[index].label.replaceAll('\n', ' ')),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88,
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.lavender, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavenderDeep.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.lavenderLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: AppColors.lavenderDeep),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppFonts.captionM.apply(color: AppColors.ink),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
