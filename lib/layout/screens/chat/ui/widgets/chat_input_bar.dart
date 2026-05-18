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
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderPrimary)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.image_outlined, color: AppColors.primaryColor),
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
                style: AppFonts.f14r,
                decoration: InputDecoration(
                  hintText: 'Ask AI about your pet...',
                  hintStyle:
                      AppFonts.f14r.apply(color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.surfaceTertiary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
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
              Icons.send,
              color: sending ? AppColors.textTertiary : AppColors.primaryColor,
            ),
            onPressed: sending ? null : onSend,
          ),
        ],
      ),
    );
  }
}
