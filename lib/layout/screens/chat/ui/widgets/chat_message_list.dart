import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import 'chat_message_bubble.dart';
import 'chat_typing_indicator.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    required this.sending,
    required this.scrollController,
  });

  final List<ChatMessage> messages;
  final bool sending;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !sending) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Ask AI about your pet\'s health.\nYou can attach photos for reference.',
            style: AppFonts.f14r.apply(color: AppColors.textTertiary),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: messages.length + (sending ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= messages.length) {
          return const ChatTypingIndicator();
        }
        return ChatMessageBubble(message: messages[index]);
      },
    );
  }
}
