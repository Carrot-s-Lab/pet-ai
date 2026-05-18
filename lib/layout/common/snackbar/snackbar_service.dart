import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class SnackBarService {
  static Future<void> showSnackBar(
      BuildContext context,
      SnackBarType type,
      String text, {
        Function? onPressed,
        int? seconds,
      }) async {
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds ?? 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CustomSnackBar(text: text, type: type),
      ),
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  final String text;
  final SnackBarType type;

  const CustomSnackBar({
    super.key,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.blue;
    Color mainColor = Colors.blue;
    IconData icon = Icons.info;

    switch (type) {
      case SnackBarType.success:
        borderColor = AppColors.primaryColor;
        mainColor = AppColors.primaryColor;
        icon = Icons.check;
        break;
      case SnackBarType.error:
        borderColor = AppColors.red;
        mainColor = AppColors.red;
        icon = Icons.close;
        break;
      case SnackBarType.warning:
        borderColor = AppColors.orange;
        mainColor = AppColors.orange;
        icon = Icons.info;
        break;
    }
    return Container(
      height: 56,
      width: 200,
      decoration: BoxDecoration(
        color: mainColor,
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: mainColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppFonts.f14m.apply(color: Colors.white),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

enum SnackBarType { success, error, warning }