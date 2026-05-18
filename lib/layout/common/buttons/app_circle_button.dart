import 'package:pet_ai_project/core/extensions/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bouncing.dart';
import '../widgets/highlight_on_tap.dart';

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({
    super.key,
    required this.onTap,
    required this.svgIcon,
    this.iconColor,
    this.backgroundColor,
    this.buttonSize = 40,
    this.iconSize = 16,
  });

  final String svgIcon;
  final void Function() onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final double buttonSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      child: Container(
        alignment: Alignment.center,
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Colors.white.withValues(alpha: .1),
        ),
        child: HighlightOnTap(
          onTap: onTap,
          effectRadius: BorderRadius.circular(buttonSize / 2),
          child: Center(
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: SvgPicture.asset(
                svgIcon,
                colorFilter: iconColor?.toColorFilter(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
