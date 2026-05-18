import 'package:flutter/cupertino.dart';

class SafeChangeNotifier extends ChangeNotifier {
  var _mounted = true;

  @override
  void notifyListeners() {
    if (!_mounted) return;

    super.notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}