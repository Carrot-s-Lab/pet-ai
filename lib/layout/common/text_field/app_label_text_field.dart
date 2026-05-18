import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class AppLabelTextField extends StatelessWidget {
  const AppLabelTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    this.width,
    this.labelText,
    this.labelWidget,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.hintText,
    this.suffixIcon,
    this.autoFocus = false,
    this.enabledBorder = true,
    this.obscureText = false,
    this.contentPadding,
    this.textStyle,
    this.onChanged,
    this.validator
  });

  final bool obscureText;
  final double? width;
  final TextEditingController controller;
  final String? labelText;
  final Widget? labelWidget;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final String? hintText;
  final Widget? suffixIcon;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool enabledBorder;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        width: width,
        padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        decoration: BoxDecoration(
          color: fillColor ?? AppColors.surfacePrimary,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          border: Border.all(
            color: borderColor ?? AppColors.borderPrimary,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  labelWidget ??
                      Text(
                        labelText ?? '',
                        style: AppFonts.f12r.apply(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  const Gap(2),
                  SizedBox(
                    height: 20,
                    child: TextField(
                      obscureText: obscureText,
                      controller: controller,
                      autofocus: autoFocus,
                      focusNode: focusNode,
                      style: textStyle ?? AppFonts.f14r,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      maxLines: 1,
                      onChanged: onChanged,
                    ),
                  )
                ],
              ),
            ),
            if (suffixIcon != null) ...[
              const Gap(4),
              suffixIcon!,
            ]
          ],
        ),
      ),
    );
  }
}
