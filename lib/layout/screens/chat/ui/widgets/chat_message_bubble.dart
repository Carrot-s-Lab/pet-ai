import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatMessageRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: isUser ? _UserBubble(message: message) : _AiBubble(message: message),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: const BoxDecoration(
        color: AppColors.caramel,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x4DD39654),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.imagePaths.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: message.imagePaths
                  .map((path) => _ImageThumbnail(path: path, size: 120))
                  .toList(),
            ),
            if (message.content.isNotEmpty) const SizedBox(height: 8),
          ],
          if (message.content.isNotEmpty)
            Text(
              message.content,
              style: AppFonts.bodyM.apply(color: AppColors.white),
            ),
          if (message.status == ChatMessageStatus.failed)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Failed to send',
                style: AppFonts.captionM.apply(color: AppColors.caramelLight),
              ),
            ),
        ],
      ),
    );
  }
}

class _AiBubble extends StatelessWidget {
  const _AiBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imagePaths.isNotEmpty) ...[
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: message.imagePaths
                    .map((path) => _ImageThumbnail(path: path, size: 120))
                    .toList(),
              ),
              if (message.content.isNotEmpty) const SizedBox(height: 8),
            ],
            MarkdownBody(
              data: message.content,
              styleSheet: MarkdownStyleSheet(
                p: AppFonts.bodyM.apply(color: AppColors.ink),
                h1: AppFonts.h2.apply(color: AppColors.ink),
                h2: AppFonts.h3.apply(color: AppColors.ink),
                h3: AppFonts.h4.apply(color: AppColors.ink),
                strong: AppFonts.f16s.apply(color: AppColors.ink),
                listBullet: AppFonts.bodyM.apply(color: AppColors.ink),
              ),
            ),
            if (message.status == ChatMessageStatus.failed)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Error',
                  style: AppFonts.captionM.apply(color: AppColors.urgent),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Not veterinary advice. Consult a vet if symptoms persist.',
              style: AppFonts.captionS.copyWith(
                color: AppColors.stone,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({required this.path, required this.size});

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: size,
          height: size,
          color: AppColors.mist,
          child: const Icon(Icons.broken_image, color: AppColors.stone),
        ),
      ),
    );
  }
}
