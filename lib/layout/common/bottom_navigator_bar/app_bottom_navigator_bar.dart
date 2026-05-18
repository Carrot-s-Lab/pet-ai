// // ignore_for_file: deprecated_member_use
//
// import 'package:education_app/core/extensions/intl.dart';
// import 'package:education_app/layout/common/color/app_color.dart';
// import 'package:education_app/layout/common/widgets/highlight_on_tap.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../generated/assets.dart';
//
// class MainBottomNavigationBar extends StatelessWidget {
//   const MainBottomNavigationBar({
//     super.key,
//   });
//
//   Widget _item(
//       {required String icon,
//         required String label,
//         required bool isSelected,
//         required void Function() onTap}) {
//     return Padding(
//       padding: EdgeInsets.all(10.w),
//       child: HighlightOnTap(
//         onTap: onTap,
//         effectRadius: BorderRadius.circular(16.w),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                   width: 24.w,
//                   height: 24.w,
//                   child: SvgPicture.asset(icon,
//                       color: isSelected ? AppColors.blue : Colors.white)),
//               SizedBox(height: 4.w),
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 12.w,
//                       color: isSelected ? AppColors.blue : Colors.white,
//                       fontWeight: FontWeight.w500))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainScaffoldController>(builder: (context, controller, _) {
//       return Padding(
//         padding: EdgeInsets.only(bottom: 10.w),
//         child: SizedBox(
//           height: 60.w + getBottomPadding(),
//           width: double.infinity,
//           child: Column(
//             children: [
//               Container(
//                 height: 1.w,
//                 color: AppColors.backgroundColor,
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: _item(
//                           icon: Assets.iconTabbarMyCodes,
//                           label: 'My Codes',
//                           isSelected: controller.currentIndex == 0,
//                           onTap: () => controller.setCurrentIndex(context, 0)),
//                     ),
//                     Expanded(
//                       child: _item(
//                           icon: Assets.iconTabbarScan,
//                           label: 'Scan',
//                           isSelected: controller.currentIndex == 1,
//                           onTap: () => controller.setCurrentIndex(context, 1)),
//                     ),
//                     Expanded(
//                       child: _item(
//                           icon: Assets.iconTabbarHistory,
//                           label: 'History',
//                           isSelected: controller.currentIndex == 2,
//                           onTap: () => controller.setCurrentIndex(context, 2)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
//
// class _BottomNavigationBarItem extends StatelessWidget {
//   final Widget icon;
//   final String label;
//   final bool isSelected;
//   final void Function() onTap;
//
//   const _BottomNavigationBarItem({
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final primary = AppTheme.of(context).colorScheme.primary;
//     final surface2 = AppTheme.of(context).colorScheme.textSecondary;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.only(
//             bottom: 8,
//             top: 8,
//           ),
//           color: AppTheme.of(context).colorScheme.background,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ShaderMask(
//                 shaderCallback: (rect) {
//                   return LinearGradient(
//                     colors: [
//                       if (isSelected) primary else surface2,
//                       if (isSelected) primary else surface2,
//                     ],
//                   ).createShader(rect);
//                 },
//                 child: icon,
//               ),
//               Text(
//                 label,
//                 style: TextStyle(
//                     color: isSelected ? primary : surface2, fontSize: 12),
//                 textScaleFactor: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
