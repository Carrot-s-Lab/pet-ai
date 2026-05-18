import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../color/app_color.dart';
import '../dialog_frame/dialog_frame.dart';
import 'list_selector.dart';

class ListPickerDialog extends StatefulWidget {
  const ListPickerDialog({
    super.key,
    required this.listValue,
    required this.title,
    required this.selectedIndex,
    required this.didChangeIndex,
  });

  final String title;
  final List<String> listValue;
  final int selectedIndex;
  final Function(int) didChangeIndex;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPickerDialog();
  }
}

class _ListPickerDialog extends State<ListPickerDialog> {
  int selectedIndex = 0;

  final controller = FixedExtentScrollController();

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.jumpToItem(widget.selectedIndex),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      child: Container(
        width: 310.w,
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 18.w,
          bottom: 24.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(widget.title, style: AppFonts.f14s),
            ),
            SizedBox(height: 9.w),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                color: AppColors.fromHex('#f6f6f6'),
              ),
              width: 278.w,
              height: 138.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    width: 278.w,
                    height: 138.w,
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        width: 262.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.w),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      width: 278.w,
                      height: 138.w,
                      child: ListSelector(
                        values: widget.listValue,
                        selectedValueIndex: selectedIndex,
                        isDisabled: (index) => false,
                        onSelectedItemChanged: (index) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        scrollController: controller,
                        alignment: Alignment.center,
                        elementHeight: 48.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.w),
            AppButton(
              width: 262.w,
              height: 36.w,
              text: 'Done',
              textStyle: AppFonts.f14s.apply(color: Colors.white),
              onTap: () {
                widget.didChangeIndex(selectedIndex);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
