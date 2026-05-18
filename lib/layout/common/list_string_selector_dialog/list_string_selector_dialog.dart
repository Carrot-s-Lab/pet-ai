import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/change_notifier.dart';
import '../../../core/utils/global.dart';
import '../../../generated/assets.dart';
import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../color/app_color.dart';
import '../custom_bottom_sheet_dialog/custom_bottom_sheet_dialog.dart';
import '../widgets/bouncing.dart';
import '../widgets/highlight_on_tap.dart';
import 'controller.dart';

class ListStringSelectorDialog extends StatelessWidget {
  const ListStringSelectorDialog(
      {super.key,
      required this.listValues,
      required this.didSelectIndex,
      this.selectedValue,
      this.title = '',
      this.saveButtonContent = ''});

  final String title;
  final List<String> listValues;
  final int? selectedValue;
  final void Function(int) didSelectIndex;
  final String saveButtonContent;

  double getWidgetHeight() {
    final textWidth = sWIDTH - 48 - 32;
    final paddingTopAndBottom = 48 + 16;
    final titleHeight = getTextHeight(textWidth, title, AppFonts.f16s);
    final spacing1 = title.isNotEmpty ? 16 : 0;
    var valuesHeight = 0.0;
    for (var value in listValues) {
      final padding = 32;
      final contentHeight = getTextHeight(textWidth, value, AppFonts.f14r);
      final valueHeight = padding + contentHeight;
      valuesHeight += valueHeight;
    }
    final spacingListValues = (listValues.length - 1) * 8;
    final spacing2 = 10;
    final saveButtonHeight = 48;

    final widgetHeight =
        paddingTopAndBottom + titleHeight + spacing1 + valuesHeight + spacingListValues + spacing2 + saveButtonHeight;
    final maxWidgetHeight = sHEIGHT * 0.8;

    return widgetHeight > maxWidgetHeight ? maxWidgetHeight : widgetHeight;
  }

  @override
  Widget build(BuildContext context) {
    return BaseChangeNotifierProvider(
        create: () => ListStringSelectorController()
          ..initialize(
            selectedValue: selectedValue,
            listValues: listValues,
          ),
        builder: (context, controller, _) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Colors.white),
            child: Column(
              children: [
                const Gap(24),
                Visibility(
                  visible: title.isNotEmpty,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 16, left: 24),
                    child: Text(title, style: AppFonts.f16s),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                      physics: const BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = listValues[index];
                        final isSelected = controller.selectedIndex == index;
                        return Bouncing(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: isSelected ? AppColors.selectedSurface : Colors.white,
                            ),
                            child: HighlightOnTap(
                              padding: const EdgeInsets.all(16),
                              onTap: () {
                                controller.setSelectedIndex(index);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        data,
                                        style: AppFonts.f14r,
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                  const Gap(8),
                                  Opacity(
                                    opacity: isSelected ? 1 : 0,
                                    child: SvgPicture.asset(Assets.iconsBack),
                                  ),
                                  const Gap(8),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(8);
                      },
                      itemCount: listValues.length),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10, bottom: sBOTTOMPADDING),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -10),
                        blurRadius: 20,
                        color: Colors.black.withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                  child: AppButton(
                    isEnabled: controller.selectedIndex != null,
                    borderRadius: BorderRadius.circular(24),
                    height: 48,
                    width: 327,
                    text: saveButtonContent.isEmpty ? 'Select' : saveButtonContent,
                    onTap: () {
                      if (controller.selectedIndex != null) {
                        didSelectIndex(controller.selectedIndex!);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

void showListStringSelectorDialog(
    {required BuildContext context,
    required List<String> values,
    required Function(int) didSelect,
    int? selectedValue,
    String title = '',
    String saveButtonContent = ''}) {
  int? newValue;
  final widget = ListStringSelectorDialog(
    listValues: values,
    selectedValue: selectedValue,
    title: title,
    saveButtonContent: saveButtonContent,
    didSelectIndex: (newSelected) {
      newValue = newSelected;
    },
  );
  showCustomBottomSheetDialog(
    height: widget.getWidgetHeight() + 8,
    childDialog: widget,
    context: context,
  ).then((value) {
    if (newValue != null) {
      didSelect(newValue!);
    }
  });
}
