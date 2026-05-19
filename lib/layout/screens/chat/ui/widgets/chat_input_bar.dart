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
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _CircleIconButton(
            icon: Icons.add_photo_alternate_outlined,
            onTap: sending ? null : onPickImages,
            enabled: !sending,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 120),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                enabled: !sending,
                style: AppFonts.bodyM.apply(color: AppColors.ink),
                decoration: InputDecoration(
                  hintText: 'Ask anything about your cat...',
                  hintStyle: AppFonts.bodyM.apply(color: AppColors.pebble),
                  filled: true,
                  fillColor: AppColors.cardSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.mist, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.mist, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColors.lavenderDeep, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _SendButton(sending: sending, onSend: onSend),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled ? AppColors.cardSurface : AppColors.cloud,
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? AppColors.mist : AppColors.cloud,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 22,
          color: enabled ? AppColors.stone : AppColors.pebble,
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
    return GestureDetector(
      onTap: sending ? null : onSend,
      child: Container(
        width: 44,
        height: 44,
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
        child: const Icon(Icons.arrow_upward_rounded, color: AppColors.appWhite, size: 22),
      ),
    );
  }
}
