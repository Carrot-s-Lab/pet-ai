import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.sending,
    required this.onPickImages,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onPickImages;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.mist, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A1611).withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _PhotoButton(sending: sending, onTap: onPickImages),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 6,
                  enabled: !sending,
                  style: AppFonts.bodyM.apply(color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: 'Ask anything about your cat...',
                    hintStyle: AppFonts.bodyM.apply(color: AppColors.pebble),
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 14,
                    ),
                  ),
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ),
            _SendButton(sending: sending, onSend: onSend),
          ],
        ),
      ),
    );
  }
}

class _PhotoButton extends StatelessWidget {
  const _PhotoButton({required this.sending, required this.onTap});

  final bool sending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sending ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 28,
          color: sending ? AppColors.pebble : AppColors.stone,
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.sending, required this.onSend});

  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 10, 8),
      child: GestureDetector(
        onTap: sending ? null : onSend,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: sending
                ? null
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.caramel, AppColors.caramelDeep],
                  ),
            color: sending ? AppColors.pebble : null,
            boxShadow: sending
                ? null
                : [
                    BoxShadow(
                      color: AppColors.caramel.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: const Icon(
            Icons.arrow_upward_rounded,
            color: AppColors.appWhite,
            size: 20,
          ),
        ),
      ),
    );
  }
}
