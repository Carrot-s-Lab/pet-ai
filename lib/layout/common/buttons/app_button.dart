// ignore_for_file: must_be_immutable
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

  static const List<Color> _defaultGradient = [
    Color(0xFFE0A55E),
    Color(0xFFD39654),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF9E92D8),
    Color(0xFF8E7FCC),
  ];

  static const List<BoxShadow> _defaultShadow = [
    BoxShadow(
      color: Color(0x59D39654),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(28);

    List<Color>? effectiveGradient;
    Color? effectiveColor;
    Color? effectiveBorder;
    List<BoxShadow>? effectiveShadow;

    if (!isEnabled) {
      effectiveColor = AppColors.mist;
      effectiveBorder = AppColors.mist;
    } else {
      final useGradient = gradientColor != null || (color == null);
      if (useGradient) {
        effectiveGradient = gradientColor ?? _defaultGradient;
      } else {
        effectiveColor = color;
        effectiveBorder = borderColor ?? color;
      }
      effectiveShadow = listBoxShadows ?? _defaultShadow;
    }

    return Bouncing(
      child: Container(
        height: height ?? 56,
        width: width,
        decoration: BoxDecoration(
          gradient: effectiveGradient != null
              ? LinearGradient(
                  begin: const Alignment(-0.5, -1),
                  end: const Alignment(0.5, 1),
                  colors: effectiveGradient,
                )
              : null,
          color: effectiveColor,
          border: effectiveGradient == null && effectiveBorder != null
              ? Border.all(color: effectiveBorder)
              : null,
          borderRadius: effectiveRadius,
          boxShadow: isEnabled ? effectiveShadow : null,
        ),
        child: HighlightOnTap(
          highlightColor: AppColors.caramelDeep.withValues(alpha: .2),
          effectRadius: effectiveRadius,
          onTap: () {
            if (isEnabled) onTap?.call();
          },
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: centerWidget ??= DefaultTextStyle(
                style: (textStyle ?? AppFonts.ctaPrimary.apply(color: AppColors.white))
                    .apply(color: isEnabled ? null : AppColors.pebble),
                child: Text(text, textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
