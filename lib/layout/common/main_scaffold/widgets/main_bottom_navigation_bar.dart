import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/route_paths.dart';
import '../../../../router/router.dart';
import '../../app_font/app_font.dart';
import '../../color/app_color.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, -4),
            color: Colors.black.withValues(
              alpha: 0.07,
            ),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomNavigationBarItem(
              icon: currentIndex == 0 ? Assets.iconsHomeSelected : Assets.iconsHome,
              label: Tr.of(context).home,
              isSelected: currentIndex == 0,
              onTap: () {
                if (currentIndex == 0) {
                  return;
                }
                HapticFeedback.lightImpact();
                appRouter.go(context, RoutePaths.home);
                // controller.setCurrentIndex(0);
              },
            ),
          ),
          Expanded(
            child: _BottomNavigationBarItem(
              icon: currentIndex == 1 ? Assets.iconsAccountSelected : Assets.iconsAccount,
              label: Tr.of(context).account,
              isSelected: currentIndex == 1,
              onTap: () {
                if (currentIndex == 1) {
                  return;
                }
                HapticFeedback.lightImpact();
                appRouter.go(context, RoutePaths.account);
                // controller.setCurrentIndex(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBarItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final void Function() onTap;

  const _BottomNavigationBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap.call();
      },
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: 12),
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(12),
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(icon),
              ),
              const Gap(8),
              Text(
                label,
                style: AppFonts.f12b.apply(
                  color: isSelected ? AppColors.primaryColor : AppColors.textQuaternary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
