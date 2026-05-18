import 'dart:async';


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/global.dart';
import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../change_notifier/safe_change_notifier.dart';
import '../color/app_color.dart';
import 'custom_bottom_sheet_dialog.dart';

Future<bool?> showDeleteAccountDialog({required BuildContext context}) async {

  void Function()? cancelTimer;

  final rs = await showCustomBottomSheetDialog<bool?>(
      context: context,
      childDialog: ChangeNotifierProvider(create: (context) {
        final controller = DeleteAccountController();
        cancelTimer = controller.cancelTimer;
        controller.startTimer();
        return controller;
      }, child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Xác nhận',
                style: AppFonts.f18b.apply(color: AppColors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(16),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Tài khoản của bạn sẽ bị xoá.\nBạn có chắc chắn muốn xoá tài khoản này không?',
                style: AppFonts.f14r.apply(color: AppColors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(35),
            Row(
              children: [
                Expanded(
                    child: AppButton(
                      height: 36,
                      text: 'Hủy',
                      color: AppColors.redLighter,
                      textStyle: AppFonts.f14s.apply(color: AppColors.red),
                      borderColor: AppColors.redLighter,
                      onTap: () => Navigator.pop(context),
                    )),
                const Gap(24),
                Expanded(
                    child: Consumer<DeleteAccountController>(builder: (context, controller, child) {
                      return AppButton(
                        onTap: () => Navigator.pop(context, true),
                        text: 'Xoá${controller.countDown > 0 ? ' (${controller.countDown})' : ''}',
                        height: 36,
                        color: AppColors.red,
                        textStyle: AppFonts.f14s.apply(color: Colors.white),
                        isEnabled: controller.countDown < 1,
                      );
                    }))
              ],
            ),
            Gap(sBOTTOMPADDING)
          ],
        ),
      )));

  cancelTimer?.call();

  return rs;
}

class DeleteAccountController extends SafeChangeNotifier {

  int countDown = 5;

  late Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      countDown -= 1;
      if (countDown == 0) {
        cancelTimer();
      }
      notifyListeners();
    });
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }
}
