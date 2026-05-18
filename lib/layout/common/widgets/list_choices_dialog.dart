import 'package:pet_ai_project/core/extensions/intl.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/global.dart';
import '../app_font/app_font.dart';
import '../buttons/app_button.dart';
import '../color/app_color.dart';
import '../dialogs/custom_bottom_sheet_dialog.dart';

class ListChoicesDialog extends StatefulWidget {
  const ListChoicesDialog({
    super.key,
    required this.choices,
    this.selectedIndex,
    this.confirmText,
  });

  final List<String> choices;
  final int? selectedIndex;
  final String? confirmText;

  static Future<int?> show({
    required BuildContext context,
    required List<String> choices,
    int? selectedIndex,
    String? confirmText,
    double? height,
  }) async {
    return await showCustomBottomSheetDialog<int?>(
      context: context,
      height: height ?? (sHEIGHT * 0.6),
      childDialog: ListChoicesDialog(
        choices: choices,
        selectedIndex: selectedIndex,
        confirmText: confirmText,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _ListChoicesDialog();
  }
}

class _ListChoicesDialog extends State<ListChoicesDialog> {
  int? selectedIndex;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    selectedIndex = widget.selectedIndex;
    if (selectedIndex != null) {
      // WidgetsBinding.instance.addPostFrameCallback((_) => scrollToSelectedContent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = widget.choices[index];
                final isSelected = index == selectedIndex;
                return AppButton(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  color:
                      isSelected
                          ? AppColors.blue
                          : AppColors.fromHex('#f6f6f6'),
                  padding: const EdgeInsets.all(16),
                  text: data,
                  textStyle: AppFonts.f14r.apply(
                    color: isSelected ? AppColors.white : null,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemCount: widget.choices.length,
            ),
          ),
          const Gap(10),
          AppButton(
            height: 48,
            width: 327.w,
            text: widget.confirmText ?? 'select',
            onTap: () => Navigator.pop(context, selectedIndex),
            isEnabled: selectedIndex != null,
          ),
        ],
      ),
    );
  }
}
