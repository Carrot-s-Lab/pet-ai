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
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 14),
      decoration: const BoxDecoration(
        color: AppColors.appWhite,
        border: Border(top: BorderSide(color: AppColors.mist, width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: sending ? AppColors.pebble : AppColors.caramel,
              size: 24,
            ),
            onPressed: sending ? null : onPickImages,
          ),
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
                  hintText: 'Ask about your cat...',
                  hintStyle: AppFonts.bodyM.apply(color: AppColors.pebble),
                  filled: true,
                  fillColor: AppColors.inputSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.caramel, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: sending ? AppColors.pebble : AppColors.caramel,
              size: 24,
            ),
            onPressed: sending ? null : onSend,
          ),
        ],
      ),
    );
  }
}
