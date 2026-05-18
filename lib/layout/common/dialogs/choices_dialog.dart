import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog_updated/flutter_animated_dialog.dart';
import 'package:gap/gap.dart';
import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../color/app_color.dart';
import '../enum/alert_type.dart';

class ChoicesDialog extends StatelessWidget {
  const ChoicesDialog({
    super.key,
    this.alertType,
    this.title,
    this.content,
    this.leftButtonText,
    this.rightButtonText,
    this.leftButtonCallBack,
    this.rightButtonCallBack,
  });

  final AlertType? alertType;
  final String? title;
  final String? content;
  final String? leftButtonText;
  final String? rightButtonText;
  final void Function()? leftButtonCallBack;
  final void Function()? rightButtonCallBack;

  static Future<void> show({
    required BuildContext context,
    AlertType? alertType,
    String? title,
    String? content,
    String? leftButtonText,
    String? rightButtonText,
    void Function()? leftButtonCallBack,
    void Function()? rightButtonCallBack,
  }) async {
    return await showAnimatedDialog(
      context: context,
      animationType: DialogTransitionType.slideFromTopFade,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return ChoicesDialog(
          alertType: alertType,
          title: title,
          content: content,
          leftButtonText: leftButtonText,
          rightButtonText: rightButtonText,
          leftButtonCallBack: leftButtonCallBack,
          rightButtonCallBack: rightButtonCallBack,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(24),
              width: 310.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  if (alertType != null)
                    Container(
                      alignment: Alignment.center,
                      height: 38.w,
                      child: alertType!.icon(size: 38.w),
                    ),
                  const Gap(12),
                  if (title != null)
                    Container(
                      alignment: Alignment.center,
                      child: Text(title ?? '', style: AppFonts.f18b),
                    ),
                  const Gap(8),
                  if (content != null)
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        content ?? '',
                        style: AppFonts.f14r,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const Gap(35),
                  Row(
                    children: [
                      AppButton(
                        height: 36,
                        width: 120.w,
                        text: leftButtonText ?? 'no',
                        color: AppColors.blue.withValues(alpha: .15),
                        textStyle: AppFonts.f14s.apply(color: AppColors.blue),
                        onTap: () {
                          leftButtonCallBack?.call();
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      AppButton(
                        height: 36,
                        width: 120.w,
                        text: rightButtonText ?? 'yes',
                        color: AppColors.blue,
                        textStyle: AppFonts.f14s.apply(color: AppColors.white),
                        onTap: () {
                          rightButtonCallBack?.call();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
