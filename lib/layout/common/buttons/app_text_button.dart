import 'package:flutter/cupertino.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.title,
    super.key,
    this.onTap,
    this.textColor,
    this.isEnabled = true,
    this.padding,
  });

  final String title;
  final void Function()? onTap;
  final Color? textColor;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? const EdgeInsets.only(left: 8, right: 8),
      onPressed: () {
        if (!isEnabled) {
          return;
        }
        onTap?.call();
      },
      child: Text(
        title,
        style: AppFonts.f16s.apply(
            color: textColor ??
                (isEnabled ? AppColors.blue : AppColors.greyTextColor)),
      ),
    );
  }
}
