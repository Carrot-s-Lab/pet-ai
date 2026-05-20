import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
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
  const MainBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  void _navigate(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    switch (index) {
      case 0:
        appRouter.go(context, RoutePaths.home);
      case 1:
        appRouter.go(context, RoutePaths.sessions);
      case 2:
        appRouter.go(context, RoutePaths.account);
    }
  }

  @override
  Widget build(BuildContext context) {
    // iOS 26+ — real native UITabBar with Apple's Liquid Glass compositor.
    // SF Symbols are rendered by UIKit; tint controls the selected accent colour.
    if (PlatformInfo.isIOS26OrHigher()) {
      return Container(
        color: Colors.transparent,
        child: IOS26NativeTabBar(
          destinations: [
            AdaptiveNavigationDestination(icon: 'house', label: Tr.of(context).home),
            const AdaptiveNavigationDestination(icon: 'message', label: 'Chat'),
            const AdaptiveNavigationDestination(icon: 'person', label: 'Profile'),
          ],
          selectedIndex: currentIndex,
          onTap: (index) => _navigate(context, index),
          tint: AppColors.caramel,
          unselectedItemTint: AppColors.stone,
          minimizeBehavior: TabBarMinimizeBehavior.never,
        ),
      );
    }

    // iOS <26 fallback — Flutter pill bar with the Catti design language.
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appWhite.withValues(alpha: 0.92),
        border: const Border(top: BorderSide(color: AppColors.mist, width: 0.5)),
        boxShadow: const [BoxShadow(color: Color(0x141A1611), blurRadius: 20, offset: Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavItem(
              icon: currentIndex == 0 ? Assets.iconsHomeSelected : Assets.iconsHome,
              label: Tr.of(context).home,
              isSelected: currentIndex == 0,
              onTap: () {
                if (currentIndex == 0) return;
                _navigate(context, 0);
              },
            ),
          ),
          Expanded(
            child: _NavItem(
              iconData: Icons.chat_bubble_outline_rounded,
              label: 'Chat',
              isSelected: currentIndex == 1,
              onTap: () {
                if (currentIndex == 1) return;
                _navigate(context, 1);
              },
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: currentIndex == 2 ? Assets.iconsAccountSelected : Assets.iconsAccount,
              label: 'Profile',
              isSelected: currentIndex == 2,
              onTap: () {
                if (currentIndex == 2) return;
                _navigate(context, 2);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({this.icon, this.iconData, required this.label, required this.isSelected, required this.onTap})
    : assert(icon != null || iconData != null, 'Provide icon or iconData');

  final String? icon;
  final IconData? iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? AppColors.caramel : AppColors.stone;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: 8),
        top: false,
        maintainBottomViewPadding: true,
        child: SizedBox(
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isSelected)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 48,
                  height: 32,
                  decoration: BoxDecoration(color: AppColors.caramelLight, borderRadius: BorderRadius.circular(16)),
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child:
                        icon != null
                            ? SvgPicture.asset(icon!, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn))
                            : Icon(iconData, size: 24, color: iconColor),
                  ),
                  const Gap(4),
                  Text(
                    label,
                    style: isSelected ? AppFonts.captionL.apply(color: AppColors.caramel) : AppFonts.captionM.apply(color: AppColors.stone),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
