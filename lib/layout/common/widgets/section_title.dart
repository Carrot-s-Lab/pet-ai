import 'package:flutter/material.dart';

import '../app_font/app_font.dart';

class SectionTitle extends StatelessWidget {

  const SectionTitle({required this.title, super.key, this.bottomPadding, this.textStyle});

  final String title;
  final double? bottomPadding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: textStyle ?? AppFonts.f14s,
      ),
    );
  }

}
