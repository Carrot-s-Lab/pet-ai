import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

class ButtonsIndicator extends StatelessWidget {
  const ButtonsIndicator({
    super.key,
    required this.selectedContent,
    required this.listContents,
    required this.onChangeSelectedType,
    required this.width,
    this.listVisibleContents,
    this.normalStyle,
    this.highlightStyle,
    this.backgroundColor,
    this.height,
    this.animationDuration,
    this.borderColor,
  });

  final String selectedContent;
  final List<String> listContents;
  final List<String>? listVisibleContents;
  final Function(String) onChangeSelectedType;
  final double width;
  final TextStyle? normalStyle;
  final TextStyle? highlightStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final Duration? animationDuration;

  double get filledColorWidth => width - 6;
  double get _height => height ?? 44.w;
  Color get _backgroundColor => backgroundColor ?? Colors.white;

  double get position {
    if (listContents.contains(selectedContent)) {
      final index = listContents.indexWhere(
        (element) => element == selectedContent,
      );
      final position = (filledColorWidth / listContents.length) * index;
      return position;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: _height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.w),
              color: _backgroundColor,
              border: Border.all(
                width: 1,
                color: borderColor ?? _backgroundColor,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                AnimatedContainer(
                  width: position,
                  height: _height,
                  color: Colors.transparent,
                  duration: const Duration(milliseconds: 200),
                ),
                Container(
                  width: filledColorWidth / listContents.length,
                  // height: 44.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.w),
                    color: AppColors.surfacePrimary,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: width,
            height: _height,
            child: Container(
              // padding: EdgeInsets.all(2.w),
              width: width,
              height: _height,
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final content = listContents[index];
                  final visibleContent =
                      listVisibleContents == null
                          ? null
                          : listVisibleContents![index];
                  return SizedBox(
                    width: filledColorWidth / listContents.length,
                    height: _height,
                    child: ButtonIndicatorElement(
                      contentElement: content,
                      visibleContent: visibleContent,
                      isSelected: selectedContent == content,
                      normalStyle: normalStyle,
                      highlightStyle: highlightStyle,
                      onTapContent: (value) {
                        onChangeSelectedType(value);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemCount: listContents.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonIndicatorElement extends StatelessWidget {
  const ButtonIndicatorElement({
    super.key,
    required this.onTapContent,
    required this.contentElement,
    required this.isSelected,
    this.normalStyle,
    this.highlightStyle,
    this.visibleContent,
  });

  final String contentElement;
  final bool isSelected;
  final Function(String) onTapContent;
  final TextStyle? normalStyle;
  final TextStyle? highlightStyle;
  final String? visibleContent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTapContent(contentElement);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(27.w),
        ),
        child: Text(
          visibleContent ?? contentElement,
          style:
              isSelected
                  ? (highlightStyle ??
                      AppFonts.f14b.apply(color: AppColors.textPrimary))
                  : (normalStyle ??
                      AppFonts.f14r.apply(color: AppColors.textTertiary)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
