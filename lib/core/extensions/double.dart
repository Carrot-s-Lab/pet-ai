
import '../utils/global.dart';

extension DoubleExtension on double {
  double get w => (toDouble() * sWIDTH) / 375.toDouble();
  double get h => (toDouble() * sHEIGHT) / 800.toDouble();
}