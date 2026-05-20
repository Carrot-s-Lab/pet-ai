import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/buttons/app_button.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:pet_ai_project/layout/common/text_field/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../controller/profile_controller.dart';

class ProfileEditSheet extends StatefulWidget {
  const ProfileEditSheet({super.key});

  @override
  State<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<ProfileEditSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _breedCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _conditionsCtrl;

  @override
  void initState() {
    super.initState();
    final c = context.read<ProfileController>();
    _nameCtrl = TextEditingController(text: c.cat?.name ?? '');
    _breedCtrl = TextEditingController(text: c.cat?.breed ?? '');
    _ageCtrl = TextEditingController(text: c.cat?.ageYears.toString() ?? '');
    _weightCtrl = TextEditingController(text: c.currentWeightKg.toString());
    _conditionsCtrl =
        TextEditingController(text: c.cat?.specialConditions.join(', ') ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _breedCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _conditionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Consumer<ProfileController>(
      builder: (context, controller, _) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.fromLTRB(24, 12, 24, bottomInset + 44),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.mist,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Edit ${controller.cat?.name ?? 'cat'}'s profile",
                  style: AppFonts.h2.apply(color: AppColors.ink),
                ),
                const SizedBox(height: 20),
                const _FormLabel('Name'),
                _field(_nameCtrl, hintText: "Cat's name"),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FormLabel('Breed'),
                          _field(_breedCtrl, hintText: 'Breed'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FormLabel('Age (years)'),
                          _field(
                            _ageCtrl,
                            hintText: 'Years',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FormLabel('Weight (kg)'),
                          _field(
                            _weightCtrl,
                            hintText: '0.0',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FormLabel('Sex'),
                          _field(
                            null,
                            hintText: controller.cat?.sex ?? '',
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _FormLabel('Lifestyle'),
                _LifestyleChips(
                  selected: controller.editLifestyle,
                  onSelect: controller.setEditLifestyle,
                ),
                const SizedBox(height: 14),
                const _FormLabel('Known conditions (optional)'),
                _field(
                  _conditionsCtrl,
                  hintText: 'e.g. Kidney disease, Diabetes…',
                ),
                const SizedBox(height: 12),
                AppButton(
                  text: 'Save changes',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _field(
    TextEditingController? ctrl, {
    String? hintText,
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    return AppTextField(
      controller: ctrl,
      hintText: hintText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      fillColor: AppColors.cloud,
      borderRadius: BorderRadius.circular(14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: false,
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: AppFonts.bodyS.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.stone,
        ),
      ),
    );
  }
}

class _LifestyleChips extends StatelessWidget {
  const _LifestyleChips({required this.selected, required this.onSelect});

  final String selected;
  final void Function(String) onSelect;

  static const _options = [
    ('🏠', 'Indoor'),
    ('🌿', 'Outdoor'),
    ('🔀', 'Mixed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _options.asMap().entries.map((entry) {
        final i = entry.key;
        final option = entry.value;
        final label = option.$2;
        final isSelected = selected == label;
        final isLast = i == _options.length - 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 6),
            child: GestureDetector(
              onTap: () => onSelect(label),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.caramelWash : AppColors.cloud,
                  border: Border.all(
                    color: isSelected ? AppColors.caramel : Colors.transparent,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    '${option.$1} $label',
                    style: AppFonts.ctaTertiary.apply(
                      color: isSelected
                          ? AppColors.caramelDeep
                          : AppColors.stone,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
