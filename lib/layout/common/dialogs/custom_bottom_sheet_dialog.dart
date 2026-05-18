import 'package:flutter/material.dart';

Future<T?> showCustomBottomSheetDialog<T>({
  required Widget childDialog,
  required BuildContext context,
  double? height,
  bool? isScrollControlled,
  bool? isCenterAlignment,
  Color? backgroundColor,
}) async {
  return showModalBottomSheet<T>(
    context: context,
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
            ),
          ),
          SizedBox(height: height, child: childDialog),
          if (true == isCenterAlignment)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      );
    },
  );
}