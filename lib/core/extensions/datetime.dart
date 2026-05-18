import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateString(String dateFormat) {
    return DateFormat(dateFormat).format(toLocal());
  }

  static DateTime fromTimeStamp(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }
}