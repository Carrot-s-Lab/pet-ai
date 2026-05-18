import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../color/app_color.dart';

late BuildContext dialogContext;
var canHideLoadingDialog = true;

Widget loadingTheme({Color? color, double? width, double? height}) {
  return SizedBox(
    width: width ?? 50.w,
    height: height ?? 50.w,
    child: LoadingIndicator(
      indicatorType: Indicator.circleStrokeSpin,
      colors: [color ?? AppColors.primaryColor],
      strokeWidth: 4,
    ),
    // child: Lottie.asset(
    //     'image_lotties/among_us_loading.json'
    // 'image_lotties/hand_loading.json',
    // 'image_lotties/new_year_loading_theme.json',
    // repeat: true, // Set whether the animation should repeat
    // reverse: false, // Set whether the animation should play in reverse
    // animate: true, // Set whether the animation should start immediately
    // )
  );
}

void showLoadingDialog(
  BuildContext context, {
  bool canHideLoadingDialog = false,
}) {
  showDialog(
    barrierDismissible: canHideLoadingDialog,
    barrierColor: Colors.white.withValues(alpha: .2),
    context: context,
    builder: (BuildContext context) {
      dialogContext = context;
      return PopScope(
        canPop: !canHideLoadingDialog,
        child: GestureDetector(
          onTap: () {
            if (canHideLoadingDialog) {
              Navigator.pop(context);
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [loadingTheme()],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void hideLoadingDialog() {
  canHideLoadingDialog = true;
  Navigator.pop(dialogContext);
}
