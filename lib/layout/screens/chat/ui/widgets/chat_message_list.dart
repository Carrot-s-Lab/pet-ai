import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';

import 'chat_message_bubble.dart';
import 'chat_typing_indicator.dart';
import 'chat_welcome_message.dart';

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
    // slots: 1 welcome + optional loadingMore + messages + optional typing
    final int loadingOffset = loadingMore ? 1 : 0;
    final int itemCount =
        1 + loadingOffset + messages.length + (sending ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Slot 0 — always the welcome message (typewriter animation on first load)
        if (index == 0) return const ChatWelcomeMessage();

        final adjusted = index - 1;

        // Slot 1 — load-more spinner (when paginating back)
        if (loadingMore && adjusted == 0) return const _LoadingMoreIndicator();

        final msgIndex = adjusted - loadingOffset;

        // Last slot — typing indicator while AI is responding
        if (msgIndex >= messages.length) return const ChatTypingIndicator();

        return ChatMessageBubble(message: messages[msgIndex]);
      },
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
