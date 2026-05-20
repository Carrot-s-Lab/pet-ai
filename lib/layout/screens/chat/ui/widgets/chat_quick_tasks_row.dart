import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

const _kTasks = [
  (label: 'Symptom\ncheck', icon: Icons.health_and_safety_outlined, color: AppColors.wellness),
  (label: 'Is this\nurgent?', icon: Icons.warning_amber_rounded, color: AppColors.urgent),
  (label: 'Diet\nadvice', icon: Icons.restaurant_outlined, color: AppColors.caramel),
  (label: 'Behaviour\nquestion', icon: Icons.psychology_outlined, color: AppColors.lavenderDeep),
  (label: 'Vet visit\nprep', icon: Icons.local_hospital_outlined, color: AppColors.info),
  (label: 'Medication\nreminder', icon: Icons.medication_outlined, color: AppColors.amber),
];

class ChatQuickTasksRow extends StatelessWidget {
  const ChatQuickTasksRow({super.key, required this.onSelect});

  final void Function(String task) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _kTasks.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => _TaskCard(
          label: _kTasks[index].label,
          icon: _kTasks[index].icon,
          color: _kTasks[index].color,
          onTap: () => onSelect(_kTasks[index].label.replaceAll('\n', ' ')),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.appWhite.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.appWhite.withValues(alpha: 0.8),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: 32, color: color),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style: AppFonts.captionL.apply(color: AppColors.ink),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
