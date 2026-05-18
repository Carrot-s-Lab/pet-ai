
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

double sWIDTH = 0;
double sHEIGHT = 0;
double sTOPSAFEAREA = 0;
double sBOTTOMSAFEAREA = 0;
double sBOTTOMPADDING = 0;

void updateScreenSize({required MediaQueryData data}) {
  // quick access to screen size without context
  sWIDTH = data.size.width;
  sHEIGHT = data.size.height;
  sTOPSAFEAREA = data.padding.top;
  sBOTTOMSAFEAREA = data.padding.bottom;
}

void copyText(String value) {
  HapticFeedback.mediumImpact();
  Clipboard.setData(ClipboardData(text: value));
}

Future<String> getCopiedText() async {
  final data = await FlutterClipboard.paste();
  return data;
}

double getTextHeight(double textWidth, String text, TextStyle textStyle) {
  final constraints = ui.ParagraphConstraints(
      width: textWidth); // Set the desired width for the text
  final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: textStyle.fontSize,
      fontStyle: textStyle.fontStyle,
      fontWeight: textStyle.fontWeight,
      fontFamily: textStyle.fontFamily))
    ..addText(text);
  final paragraph = paragraphBuilder.build();
  paragraph.layout(constraints);
  final textHeight = paragraph.height;
  return textHeight;
}

double getTextWidth(String text, TextStyle textStyle) {
  TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textDirection: ui.TextDirection.ltr);

  painter.layout();

  return painter.width;
}

double? getPositionToScrollWidget(
    {required GlobalKey widgetKey,
    required GlobalKey scrollViewKey,
    required ScrollController scrollController}) {

  RenderBox widgetRenderBox =
      widgetKey.currentContext!.findRenderObject() as RenderBox;
  double widgetTopPositionInScreen = widgetRenderBox.localToGlobal(Offset.zero).dy;
  double widgetHeight = widgetRenderBox.size.height;

  RenderBox scrollRenderBox =
      scrollViewKey.currentContext!.findRenderObject() as RenderBox;
  double scrollViewTopPositionInScreen =
      scrollRenderBox.localToGlobal(Offset.zero).dy;
  double scrollViewHeight = scrollRenderBox.size.height;

  final widgetTopPositionInScrollView = scrollController.offset +
      widgetTopPositionInScreen -
      scrollViewTopPositionInScreen;
  final widgetBottomPositionInScrollView =
      widgetTopPositionInScrollView + widgetHeight;

  if (scrollController.position.maxScrollExtent <= 0 &&
      widgetTopPositionInScreen > scrollViewTopPositionInScreen) {
    return null;
  }

  if (widgetHeight + scrollController.position.maxScrollExtent > scrollViewHeight) {
    return widgetTopPositionInScrollView;
  } else {
    return widgetBottomPositionInScrollView;
  }
}

String formatSecondsDuration(int seconds) {
  // Các hằng số
  const int secondsPerMinute = 60;
  const int secondsPerHour = 60 * 60;
  const int secondsPerDay = 24 * 60 * 60;

  // Tính toán thời gian
  int days = seconds ~/ secondsPerDay;
  seconds %= secondsPerDay;

  int hours = seconds ~/ secondsPerHour;
  seconds %= secondsPerHour;

  int minutes = seconds ~/ secondsPerMinute;

  // Xây dựng chuỗi kết quả
  List<String> parts = [];

  if (days <= 0) {
    parts.add('${seconds ~/ 60} giây');
    return parts.join(' ');
  }
  if (days > 0) parts.add('$days ngày');
  if (hours > 0) parts.add('$hours tiếng');
  if (minutes > 0) parts.add('$minutes phút');

  return parts.join(' ');
}

double getScrollOffSetFromListData(
    {required List<dynamic> listData,
      required double spacing,
      required bool Function(dynamic) isIndexToScroll,
      required double Function(dynamic) sizeForEachElement}) {
  double scrollOffSet = 0.0;
  for (int i = 0; i < listData.length; i++) {
    if (isIndexToScroll(listData[i])) {
      break;
    }
    scrollOffSet += sizeForEachElement(listData[i]);
    if (i == listData.length - 1) {
      scrollOffSet += spacing;
    }
  }
  return scrollOffSet;
}
