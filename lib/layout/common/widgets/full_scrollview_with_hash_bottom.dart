import 'package:flutter/cupertino.dart';

import '../../../core/utils/global.dart';
import '../app_bar/common_appbar.dart';

class FullScrollViewWithHashBottom extends StatelessWidget {
  const FullScrollViewWithHashBottom({
    required this.body,
    required this.bottomWidget,
    super.key,
    this.scrollPhysics,
    this.padding,
    this.onRefresh,
  });

  final Widget body;
  final Widget bottomWidget;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? padding;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: SizedBox(
        height: sHEIGHT - defaultHeightAppbar,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: padding ?? const EdgeInsets.all(24),
                child: body,
              ),
            ),
            bottomWidget,
          ],
        ),
      ),
    );
  }
}
