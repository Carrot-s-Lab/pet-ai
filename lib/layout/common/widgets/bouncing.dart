// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';

class Bouncing extends StatefulWidget {
  Bouncing({required this.child, super.key});

  Widget child;

  @override
  State<StatefulWidget> createState() {
    return _Bouncing();
  }
}

class _Bouncing extends State<Bouncing>
    with SingleTickerProviderStateMixin {

  double? _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      upperBound: 0.07,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _controller.forward();
      },
      onTapUp: (TapUpDetails details) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
