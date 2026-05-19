import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingNameStep extends StatefulWidget {
  const OnboardingNameStep({super.key, required this.initialName, required this.onChanged});

  final String initialName;
  final ValueChanged<String> onChanged;

  @override
  State<OnboardingNameStep> createState() => _OnboardingNameStepState();
}

class _OnboardingNameStepState extends State<OnboardingNameStep> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s your\ncat\'s name?',
          style: AppFonts.displayM.apply(color: AppColors.ink),
        ),
        const Gap(8),
        Text(
          'We\'ll personalise everything just for them.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(32),
        TextField(
          controller: _textController,
          style: AppFonts.bodyL.apply(color: AppColors.ink),
          textCapitalization: TextCapitalization.words,
          autofocus: true,
          cursorColor: AppColors.caramel,
          decoration: InputDecoration(
            hintText: 'e.g. Luna',
            hintStyle: AppFonts.bodyL.apply(color: AppColors.pebble),
            fillColor: AppColors.inputSurface,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.caramel, width: 1.5),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
