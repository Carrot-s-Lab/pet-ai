import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

    // During the current session: show local paths.
    // After reload from Firestore: show remote URLs.
    final hasImages =
        message.imagePaths.isNotEmpty || message.imageUrls.isNotEmpty;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.selectedSurface : AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (hasImages) ...[
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _buildImageThumbnails(),
              ),
              if (message.content.isNotEmpty) const SizedBox(height: 8),
            ],
            if (isUser)
              Text(message.content, style: AppFonts.f14r)
            else
              MarkdownBody(
                data: message.content,
                styleSheet: MarkdownStyleSheet(
                  p: AppFonts.f14r,
                  h1: AppFonts.f18b,
                  h2: AppFonts.f16b,
                  h3: AppFonts.f14b,
                  strong: AppFonts.f14s,
                  listBullet: AppFonts.f14r,
                ),
              ),
            if (message.status == ChatMessageStatus.failed)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Error',
                  style: AppFonts.f12r.apply(color: AppColors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageThumbnails() {
    // Prefer remote URLs (persisted state); fall back to local paths (current session).
    if (message.imageUrls.isNotEmpty) {
      return message.imageUrls
          .map((url) => _NetworkImageThumbnail(url: url, size: 120))
          .toList();
    }
    return message.imagePaths
        .map((path) => _LocalImageThumbnail(path: path, size: 120))
        .toList();
  }
}

class _LocalImageThumbnail extends StatelessWidget {
  const _LocalImageThumbnail({required this.path, required this.size});

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _BrokenImage(size: size),
      ),
    );
  }
}

class _NetworkImageThumbnail extends StatelessWidget {
  const _NetworkImageThumbnail({required this.url, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(
          width: size,
          height: size,
          color: AppColors.borderPrimary,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (_, _, _) => _BrokenImage(size: size),
      ),
    );
  }
}

class _BrokenImage extends StatelessWidget {
  const _BrokenImage({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColors.borderPrimary,
      child: Icon(Icons.broken_image, color: AppColors.textTertiary),
    );
  }
}
