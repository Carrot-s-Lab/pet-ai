// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';
import '../widgets/bouncing.dart';
import '../widgets/highlight_on_tap.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    this.text = '',
    this.height,
    this.width,
    this.onTap,
    this.borderColor,
    this.textStyle,
    this.isEnabled = true,
    this.color,
    this.gradientColor,
    this.borderRadius,
    this.padding,
    this.centerWidget,
    this.listBoxShadows,
  });

  double? height;
  double? width;
  String text;
  Color? color;
  List<Color>? gradientColor;
  Color? borderColor;
  void Function()? onTap;
  TextStyle? textStyle;
  bool isEnabled;
  BorderRadius? borderRadius;
  EdgeInsetsGeometry? padding;
  Widget? centerWidget;
  List<BoxShadow>? listBoxShadows;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      color = AppColors.surfaceSecondary;
      borderColor = AppColors.surfaceSecondary;
      gradientColor = null;
    } else {
      if (gradientColor != null) {
        color = null;
      } else if (gradientColor == null && color == null) {
        color = AppColors.primaryColor;
      }
      borderColor ??= (gradientColor != null ? gradientColor![0] : color);
    }

    return Bouncing(
      child: Container(
        height: height ?? 48,
        width: width,
        decoration: BoxDecoration(
          gradient: gradientColor != null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColor!,
                )
              : null,
          color: color,
          border:
              gradientColor == null ? Border.all(color: borderColor!) : null,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          boxShadow: listBoxShadows,
        ),
        child: HighlightOnTap(
          highlightColor: AppColors.fromHex('#2F9EF2').withValues(alpha: .3),
          effectRadius: borderRadius ?? BorderRadius.circular(10),
          onTap: () {
            if (isEnabled) {
              onTap?.call();
            }
          },
          child: Padding(
            padding: padding ?? const EdgeInsets.only(left: 18, right: 18),
            child: Center(
              child: centerWidget ??= DefaultTextStyle(
                style: (textStyle ??
                    AppFonts.f14b.apply(
                      color:  AppColors.white,
                    )).apply(color: isEnabled ? null : AppColors.textTertiary),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
