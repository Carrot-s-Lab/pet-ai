import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

const _kFullText =
    "Hi! I'm Catti 🐱\nAsk me anything about your pet — symptoms, diet, behaviour, or just general questions.";
const _kCharDelay = Duration(milliseconds: 28);

class ChatWelcomeMessage extends StatefulWidget {
  const ChatWelcomeMessage({super.key});

  @override
  State<ChatWelcomeMessage> createState() => _ChatWelcomeMessageState();
}

class _ChatWelcomeMessageState extends State<ChatWelcomeMessage> {
  int _visibleChars = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_kCharDelay, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_visibleChars < _kFullText.length) {
          _visibleChars++;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _kFullText.substring(0, _visibleChars);
    final isTyping = _visibleChars < _kFullText.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 60, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/pixel_cat.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Image.asset(
                'assets/images/app_logo.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: const BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  left: BorderSide(color: AppColors.lavender, width: 3.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x121A1611),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: displayText,
                      style: AppFonts.bodyM.apply(color: AppColors.ink),
                    ),
                    if (isTyping)
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: _BlinkingCursor(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, _) => Text(
        '▎',
        style: TextStyle(
          fontSize: 14,
          color: _ctrl.value > 0.5
              ? AppColors.lavenderDeep
              : Colors.transparent,
          height: 1,
        ),
      ),
    );
  }
}
