import 'package:flutter/material.dart';

class HighlightOnTap extends StatefulWidget {
  const HighlightOnTap({
    required this.child,
    super.key,
    this.highlightColor,
    this.effectRadius,
    this.onTap,
    this.onLongPress,
    this.padding,
  });

  final Color? highlightColor;
  final BorderRadius? effectRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  State<StatefulWidget> createState() {
    return _HighlightOnTap();
  }
}

class _HighlightOnTap extends State<HighlightOnTap> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onTap?.call();
        },
        onLongPress: () {
          widget.onLongPress?.call();
        },
        borderRadius: widget.effectRadius ?? BorderRadius.circular(16),
        highlightColor: widget.highlightColor,
        child: Padding(padding: widget.padding ?? EdgeInsets.zero, child: widget.child),
      ),
    );
  }
}
