import 'package:flutter/material.dart';

class KeyboardDismissOnTap extends StatelessWidget {
  const KeyboardDismissOnTap({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
