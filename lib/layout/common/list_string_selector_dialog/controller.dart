
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../change_notifier/safe_change_notifier.dart';


class ListStringSelectorController extends SafeChangeNotifier {

  List<String> listValues = [];
  int? selectedIndex;
  ScrollController scrollController = ScrollController();

  void initialize({required int? selectedValue, required List<String> listValues}) {
    this.listValues = listValues;
    selectedIndex = selectedValue;
    if (selectedValue != null) {
      // WidgetsBinding.instance.addPostFrameCallback((_) => scrollToSelectedContent());
    }
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<void> scrollToSelectedContent() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // final selectedIndex = listValues.indexWhere((element) => element == selectedValue);
    // if (selectedIndex == -1) return;
    // final getPosition =
    // getPositionToScrollWidget(widgetKey: itemKeys[selectedIndex], scrollViewKey: scrollViewKey, scrollController: scrollController);
    // if (getPosition == null) return;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(
    //     getPosition,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });
    // final scrollOffSet = getScrollOffSetFromListData(
    //   listData: listValues,
    //   spacing: 8,
    //   isIndexToScroll: (element) {
    //     final content = element as String;
    //     return content == selectedValue;
    //   },
    //   sizeForEachElement: (element) {
    //     final content = element as String;
    //     return getTextHeight(327, content, AppFonts.f14r) + 32;
    //   },
    // );
    // log('scrollOffSet: $scrollOffSet');
    // scrollController.animateTo(
    //   scrollOffSet,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.bounceInOut,
    // );
    // scrollController.jumpTo(scrollOffSet);
  }
}