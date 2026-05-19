import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatTypingIndicator extends StatefulWidget {
  const ChatTypingIndicator({super.key});

  @override
  State<ChatTypingIndicator> createState() => _ChatTypingIndicatorState();
}

class _ChatTypingIndicatorState extends State<ChatTypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(13, 12, 16, 12),
        decoration: const BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border(left: BorderSide(color: AppColors.lavender, width: 3.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0x121A1611),
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _RunningCat(controller: _controller),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _BouncingDots(controller: _controller),
                const SizedBox(height: 4),
                Text(
                  'Thinking...',
                  style: AppFonts.captionM.apply(color: AppColors.stone),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RunningCat extends StatelessWidget {
  const _RunningCat({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        final t = controller.value;
        final bounce = -math.sin(t * math.pi * 2) * 3.0;
        final tilt = math.sin(t * math.pi * 2) * 0.15;
        return Transform.translate(
          offset: Offset(0, bounce),
          child: Transform.rotate(
            angle: tilt,
            child: child,
          ),
        );
      },
      child: ClipOval(
        child: Image.asset(
          'assets/images/pixel_cat.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Image.asset(
            'assets/images/app_logo.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _BouncingDots extends StatelessWidget {
  const _BouncingDots({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = (controller.value + i / 3.0) % 1.0;
            final offset = -math.sin(phase * math.pi * 2).clamp(-1.0, 0.0) * 5.0;
            return Transform.translate(
              offset: Offset(0, offset),
              child: Container(
                margin: EdgeInsets.only(right: i < 2 ? 5 : 0),
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.lavender,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
