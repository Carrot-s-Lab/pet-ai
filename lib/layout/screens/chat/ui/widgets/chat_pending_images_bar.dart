import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class ChatPendingImagesBar extends StatelessWidget {
  const ChatPendingImagesBar({
    super.key,
    required this.paths,
    required this.onRemove,
  });

  final List<String> paths;
  final void Function(String path) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        border: Border(top: BorderSide(color: AppColors.borderPrimary)),
      ),
      child: SizedBox(
        height: 72,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: paths.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final path = paths[index];
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(path),
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: IconButton(
                    icon: const Icon(Icons.cancel, size: 20),
                    color: AppColors.red,
                    onPressed: () => onRemove(path),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
