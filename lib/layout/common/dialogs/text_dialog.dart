import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog_updated/flutter_animated_dialog.dart';

import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../enum/alert_type.dart';

class TextDialog extends StatelessWidget {
  const TextDialog({
    super.key,
    required this.alertType,
    this.title,
    this.content,
    this.confirmText,
    this.onClose,
  });

  final AlertType? alertType;
  final String? title;
  final String? content;
  final String? confirmText;
  final void Function()? onClose;

  static Future<void> show({
    required BuildContext context,
    required AlertType? alertType,
    String? title,
    String? content,
    String? confirmText,
    void Function()? onClose,
  }) async {
    return await showAnimatedDialog<void>(
      context: context,
      animationType: DialogTransitionType.slideFromTopFade,
      duration: const Duration(milliseconds: 250),
      builder: (context) {
        return TextDialog(
          alertType: alertType,
          title: title,
          content: content,
          confirmText: confirmText,
          onClose: onClose,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                width: 310.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (alertType != null)
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 40,
                        child: alertType?.icon(size: 40),
                      ),
                    if (title != null)
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: DefaultTextStyle(
                          style: AppFonts.f18b,
                          child: Text(title ?? '', textAlign: TextAlign.center),
                        ),
                      ),
                    if (content != null)
                      Container(
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: AppFonts.f14r,
                          child: Text(
                            content ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    SizedBox(height: 35.w),
                    AppButton(
                      height: 36,
                      width: null,
                      text: confirmText ?? 'close',
                      textStyle: AppFonts.f14s.apply(color: Colors.white),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
