import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class ListSelector extends StatefulWidget {
  ListSelector({
    super.key,
    required List<String> this.values,
    required this.selectedValueIndex,
    required this.onSelectedItemChanged,
    required this.scrollController,
    required this.isDisabled,
    this.alignment,
    this.elementHeight,
    this.selectedStyle,
    this.disabledStyle,
    this.unselectedStyle,
  }) {
    alignment ??= Alignment.center;
    elementHeight ??= 48.w;
    selectedStyle ??= AppFonts.f16b.apply(color: AppColors.primaryColor);
    unselectedStyle ??= AppFonts.f12s.apply(color: AppColors.textPrimary);
    disabledStyle ??= AppFonts.f12s.apply(color: AppColors.textQuaternary);
  }

  List<dynamic> values;
  int selectedValueIndex;
  void Function(int) onSelectedItemChanged;
  FixedExtentScrollController scrollController;
  bool Function(int) isDisabled;
  double? elementHeight;
  AlignmentGeometry? alignment;
  TextStyle? selectedStyle = AppFonts.f16b.apply(color: AppColors.primaryColor);
  TextStyle? disabledStyle = AppFonts.f16b.apply(color: AppColors.primaryColor);
  TextStyle? unselectedStyle = AppFonts.f16b.apply(
    color: AppColors.primaryColor,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListSelector();
  }
}

class _ListSelector extends State<ListSelector> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final values = widget.values;

    return CupertinoPicker.builder(
      childCount: values.length,
      squeeze: 1.1,
      itemExtent: 50.w,
      scrollController: widget.scrollController,
      useMagnifier: false,
      diameterRatio: 1.4,
      magnification: 1.0,
      backgroundColor: Colors.transparent,
      offAxisFraction: 0.0,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      onSelectedItemChanged: widget.onSelectedItemChanged,
      itemBuilder:
          (context, index) => Container(
            padding: EdgeInsets.only(left: 35.w, right: 35.w),
            height: widget.elementHeight,
            alignment: widget.alignment,
            child: Text(
              '${values[index]}',
              style:
                  index == widget.selectedValueIndex
                      ? widget.selectedStyle
                      : widget.isDisabled(index)
                      ? widget.disabledStyle
                      : widget.unselectedStyle,
            ),
          ),
    );
  }
}
