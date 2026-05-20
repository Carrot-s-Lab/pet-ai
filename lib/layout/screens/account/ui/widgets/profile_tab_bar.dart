import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    super.key,
    required this.activeIndex,
    required this.onTabChanged,
  });

  final int activeIndex;
  final void Function(int) onTabChanged;

  static const _tabs = ['Vaccines', 'Medications', 'Weight', 'Vet Visits'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lavenderWash,
        border: Border(bottom: BorderSide(color: AppColors.lavenderLight)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(
            _tabs.length,
            (i) => _TabItem(
              label: _tabs[i],
              isActive: i == activeIndex,
              onTap: () => onTabChanged(i),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 11),
            child: Text(
              label,
              style: (isActive ? AppFonts.f14s : AppFonts.f14m).apply(
                color: isActive ? AppColors.lavenderDeep : AppColors.pebble,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 2.5,
            width: 36,
            decoration: BoxDecoration(
              color: isActive ? AppColors.lavenderDeep : Colors.transparent,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }
}
