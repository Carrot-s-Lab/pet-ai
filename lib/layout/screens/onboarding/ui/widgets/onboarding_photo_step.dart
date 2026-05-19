import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingPhotoStep extends StatelessWidget {
  const OnboardingPhotoStep({
    super.key,
    required this.catName,
    required this.photo,
    required this.onPhotoSelected,
  });

  final String catName;
  final XFile? photo;
  final ValueChanged<XFile?> onPhotoSelected;

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) onPhotoSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    final displayName = catName.isNotEmpty ? catName : 'your cat';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a photo\nof $displayName',
          style: AppFonts.displayM.apply(color: AppColors.ink),
        ),
        const Gap(8),
        Text(
          'Helps Catti recognise them during care checks.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(32),
        photo == null
            ? _UploadPlaceholder(onTap: _pickPhoto)
            : _PhotoThumbnail(
                photo: photo!,
                onRemove: () => onPhotoSelected(null),
                onReplace: _pickPhoto,
              ),
      ],
    );
  }
}

class _UploadPlaceholder extends StatelessWidget {
  const _UploadPlaceholder({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.inputSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lavenderLight, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, size: 28, color: AppColors.lavenderDeep),
            const Gap(8),
            Text('Add a photo', style: AppFonts.captionL.apply(color: AppColors.lavenderDeep)),
          ],
        ),
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({required this.photo, required this.onRemove, required this.onReplace});

  final XFile photo;
  final VoidCallback onRemove;
  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onReplace,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              File(photo.path),
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.ink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: AppColors.appWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
