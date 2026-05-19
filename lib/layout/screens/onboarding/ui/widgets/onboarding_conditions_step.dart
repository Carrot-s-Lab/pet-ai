import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingConditionsStep extends StatefulWidget {
  const OnboardingConditionsStep({
    super.key,
    required this.catName,
    required this.selectedConditions,
    required this.onToggle,
  });

  final String catName;
  final List<String> selectedConditions;
  final ValueChanged<String> onToggle;

  @override
  State<OnboardingConditionsStep> createState() => _OnboardingConditionsStepState();
}

class _OnboardingConditionsStepState extends State<OnboardingConditionsStep> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  String _query = '';
  bool _open = false;

  static const _conditions = [
    'Allergies',
    'Asthma',
    'Diabetes',
    'Kidney Disease',
    'Heart Disease',
    'Hyperthyroidism',
    'Dental Disease',
    'Obesity',
    'Arthritis',
    'Cancer',
    'Digestive Issues',
    'Skin Condition',
  ];

  List<String> get _filtered {
    if (_query.isEmpty) return _conditions;
    final q = _query.toLowerCase();
    return _conditions.where((c) => c.toLowerCase().contains(q)).toList();
  }

  String get _fieldLabel {
    final count = widget.selectedConditions.length;
    if (count == 0) return 'Search conditions…';
    if (count == 1) return widget.selectedConditions.first;
    return '$count conditions selected';
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          setState(() {
            _open = false;
            _query = '';
          });
          _searchController.clear();
        } else {
          setState(() => _open = true);
        }
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';
    final filtered = _filtered;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Any special conditions?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text(
          'Select all that apply to $displayName. You can skip if none.',
          style: AppFonts.bodyM.apply(color: AppColors.stone),
        ),
        const Gap(24),

        // Search field
        TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: AppFonts.bodyL.apply(color: AppColors.ink),
          textCapitalization: TextCapitalization.words,
          cursorColor: AppColors.lavenderDeep,
          decoration: InputDecoration(
            hintText: _fieldLabel,
            hintStyle: AppFonts.bodyL.apply(
              color: widget.selectedConditions.isEmpty ? AppColors.pebble : AppColors.ink,
            ),
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.lavenderDeep, size: 20),
            suffixIcon: AnimatedRotation(
              duration: const Duration(milliseconds: 180),
              turns: _open ? 0.5 : 0,
              child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.lavenderDeep),
            ),
            fillColor: AppColors.lavenderWash,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.lavenderDeep, width: 1.5),
            ),
          ),
          onChanged: (v) => setState(() => _query = v),
        ),

        // Dropdown list
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: _open
              ? Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: filtered.isEmpty ? null : (filtered.length * 48.0).clamp(0, 260),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.appWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.lavenderLight),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lavenderDeep.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: filtered.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text('No conditions found', style: AppFonts.bodyM.apply(color: AppColors.stone)),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) =>
                              const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.mist),
                          itemBuilder: (context, i) {
                            final condition = filtered[i];
                            final isSelected = widget.selectedConditions.contains(condition);
                            return _ConditionRow(
                              condition: condition,
                              isSelected: isSelected,
                              onTap: () => widget.onToggle(condition),
                            );
                          },
                        ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow({required this.condition, required this.isSelected, required this.onTap});

  final String condition;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        color: isSelected ? AppColors.lavenderWash : Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(
                condition,
                style: AppFonts.bodyM.apply(color: isSelected ? AppColors.lavenderDeep : AppColors.ink),
              ),
            ),
            if (isSelected) const Icon(Icons.check_rounded, size: 18, color: AppColors.lavenderDeep),
          ],
        ),
      ),
    );
  }
}
