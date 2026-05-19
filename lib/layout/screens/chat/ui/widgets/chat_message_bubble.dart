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
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: isUser ? _UserBubble(message: message) : _AiBubble(message: message),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});

  final ChatMessage message;

  List<Widget> _buildImages() {
    if (message.imageUrls.isNotEmpty) {
      return message.imageUrls
          .map((url) => _NetworkImageThumbnail(url: url, size: 120))
          .toList();
    }
    return message.imagePaths
        .map((path) => _LocalImageThumbnail(path: path, size: 120))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = message.imagePaths.isNotEmpty || message.imageUrls.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.caramel, AppColors.caramelDeep],
        ),
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
          if (hasImages) ...[
            Wrap(spacing: 6, runSpacing: 6, children: _buildImages()),
            if (message.content.isNotEmpty) const SizedBox(height: 8),
          ],
          if (message.content.isNotEmpty)
            Text(
              message.content,
              style: AppFonts.bodyM.apply(color: AppColors.appWhite),
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

  List<Widget> _buildImages() {
    if (message.imageUrls.isNotEmpty) {
      return message.imageUrls
          .map((url) => _NetworkImageThumbnail(url: url, size: 120))
          .toList();
    }
    return message.imagePaths
        .map((path) => _LocalImageThumbnail(path: path, size: 120))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = message.imagePaths.isNotEmpty || message.imageUrls.isNotEmpty;

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
            if (hasImages) ...[
              Wrap(spacing: 6, runSpacing: 6, children: _buildImages()),
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
          ],
        ),
      ),
    );
  }
}

class _LocalImageThumbnail extends StatelessWidget {
  const _LocalImageThumbnail({required this.path, required this.size});

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
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(
          width: size,
          height: size,
          color: AppColors.mist,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppColors.caramel),
            ),
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
      color: AppColors.mist,
      child: const Icon(Icons.broken_image, color: AppColors.stone),
    );
  }
}
