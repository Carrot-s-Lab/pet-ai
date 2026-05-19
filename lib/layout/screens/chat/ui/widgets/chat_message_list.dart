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
    required this.loadingMore,
  });

  final List<ChatMessage> messages;
  final bool sending;
  final ScrollController scrollController;
  final bool loadingMore;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !sending && !loadingMore) {
      return const _WelcomeState();
    }

    final int topOffset = loadingMore ? 1 : 0;

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: topOffset + messages.length + (sending ? 1 : 0),
      itemBuilder: (context, index) {
        if (loadingMore && index == 0) {
          return const _LoadingMoreIndicator();
        }
        final msgIndex = index - topOffset;
        if (msgIndex >= messages.length) {
          return const ChatTypingIndicator();
        }
        return ChatMessageBubble(message: messages[msgIndex]);
      },
    );
  }
}

class _WelcomeState extends StatelessWidget {
  const _WelcomeState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 60, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipOval(
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
              const SizedBox(width: 10),
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
                  child: Text(
                    'What can I help you with today? 🐾',
                    style: AppFonts.bodyM.apply(color: AppColors.ink),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              'Ask me anything — symptoms, diet, behaviour, or just a general question about your cat.',
              style: AppFonts.bodyS.apply(color: AppColors.stone),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingMoreIndicator extends StatelessWidget {
  const _LoadingMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
