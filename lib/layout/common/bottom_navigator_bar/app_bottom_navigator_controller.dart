// import 'package:education_app/core/controllers/safe_change_notifier.dart';
// import 'package:flutter/material.dart';
//
// class AppBottomNavigatorController extends SafeChangeNotifier {
//   int currentIndex = 0;
//
//   void setCurrentIndex(BuildContext context, int index) {
//     currentIndex = index;
//     notifyListeners();
//     switch (index) {
//       case 0:
//         Navigator.of(context).pushNamed(Routes.myCodes);
//         break;
//       case 1:
//         Navigator.of(context).pushNamed(Routes.scan);
//         break;
//       case 2:
//         Navigator.of(context).pushNamed(Routes.history);
//         break;
//     }
//   }
// }