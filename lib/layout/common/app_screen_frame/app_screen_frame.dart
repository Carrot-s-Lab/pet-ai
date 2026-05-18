import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../color/app_color.dart';

class AppScreenFrame extends StatelessWidget {
  const AppScreenFrame({
    super.key,
    required this.appBar,
    required this.body,
    this.footer,
    this.bodyPadding,
  });

  final Widget appBar;
  final Widget body;
  final Widget? footer;
  final EdgeInsets? bodyPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: appBar,
          ),
          const Gap(4),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: bodyPadding ?? const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfacePrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: body,
            ),
          ),
          footer ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
