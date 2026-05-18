import 'dart:math';
import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../buttons/app_back_button.dart';

double get defaultHeightAppbar => min(90.h, 90.w);

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.actions,
    this.enableBackButton = true,
    this.customBackButton,
    this.titleTextStyle,
  });

  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool enableBackButton;
  final Widget? customBackButton;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              child:
                  !enableBackButton
                      ? const SizedBox()
                      : customBackButton ?? const AppBackButton(),
            ),
          ),
          titleWidget ?? Text(title, style: titleTextStyle ?? AppFonts.f16b),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: (actions ?? <Widget>[])..add(const SizedBox(width: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
