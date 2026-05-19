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

  Future<void> _pickPhoto(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PhotoSourceSheet(),
    );
    if (source == null) return;
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 80);
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
            ? _UploadPlaceholder(onTap: () => _pickPhoto(context))
            : _PhotoThumbnail(
                photo: photo!,
                onRemove: () => onPhotoSelected(null),
                onReplace: () => _pickPhoto(context),
              ),
      ],
    );
  }
}

class _PhotoSourceSheet extends StatelessWidget {
  const _PhotoSourceSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.mist,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(16),
          _SheetOption(
            icon: Icons.photo_library_outlined,
            label: 'Choose from gallery',
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
          const Divider(height: 1, indent: 56, color: AppColors.mist),
          _SheetOption(
            icon: Icons.camera_alt_outlined,
            label: 'Take a photo',
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  const _SheetOption({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.lavenderDeep, size: 24),
            const Gap(16),
            Text(label, style: AppFonts.bodyL.apply(color: AppColors.ink)),
          ],
        ),
      ),
    );
  }
}

class _UploadPlaceholder extends StatelessWidget {
  const _UploadPlaceholder({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: AppColors.lavenderWash,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lavenderLight, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, size: 32, color: AppColors.lavenderDeep),
              const Gap(8),
              Text('Add a photo', style: AppFonts.captionL.apply(color: AppColors.lavenderDeep)),
            ],
          ),
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
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onReplace,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.lavenderLight, width: 2),
              ),
              child: ClipOval(
                child: Image.file(
                  File(photo.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 32,
                height: 32,
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
