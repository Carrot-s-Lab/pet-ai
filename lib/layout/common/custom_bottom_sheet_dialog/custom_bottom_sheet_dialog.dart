import 'package:flutter/material.dart';

Future<dynamic> showCustomBottomSheetDialog<T>(
    {required BuildContext context,
    required Widget childDialog,
    double? height,
    bool? isScrollControlled,
    Color? backgroundColor}) async {
  await showModalBottomSheet<T>(
      context: context,
      constraints: null,
      isScrollControlled: isScrollControlled ?? true,
      backgroundColor: backgroundColor ?? Colors.transparent,
      builder: (context) {
        return Column(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
              ),
            )),
            SizedBox(height: height, child: childDialog),
          ],
        );
      }).then((value) {
    return value;
  });
}
