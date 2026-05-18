import '../utils/global.dart';

extension IntExtension on int {
  double get w => (toDouble() * sWIDTH) / 375.toDouble();
  double get h => (toDouble() * sHEIGHT) / 812.toDouble();
}