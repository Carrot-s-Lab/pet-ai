import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class OnboardingBreedStep extends StatefulWidget {
  const OnboardingBreedStep({
    super.key,
    required this.catName,
    required this.initialBreed,
    required this.onChanged,
  });

  final String catName;
  final String initialBreed;
  final ValueChanged<String> onChanged;

  @override
  State<OnboardingBreedStep> createState() => _OnboardingBreedStepState();
}

class _OnboardingBreedStepState extends State<OnboardingBreedStep> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  String _query = '';
  late String _selected;
  bool _open = false;

  static const _allBreeds = [
    'Mixed / Unknown',
    'Domestic Shorthair',
    'Domestic Longhair',
    'Domestic Medium Hair',
    'Abyssinian',
    'American Curl',
    'American Shorthair',
    'Bengal',
    'Birman',
    'British Shorthair',
    'Burmese',
    'Chartreux',
    'Cornish Rex',
    'Devon Rex',
    'Egyptian Mau',
    'Exotic Shorthair',
    'Himalayan',
    'Maine Coon',
    'Manx',
    'Norwegian Forest Cat',
    'Oriental Shorthair',
    'Persian',
    'Ragdoll',
    'Russian Blue',
    'Savannah',
    'Scottish Fold',
    'Siamese',
    'Siberian',
    'Somali',
    'Sphynx',
    'Tonkinese',
    'Turkish Angora',
  ];

  List<String> get _filtered {
    if (_query.isEmpty) return _allBreeds;
    final q = _query.toLowerCase();
    return _allBreeds.where((b) => b.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    _selected = widget.initialBreed;
    _searchController = TextEditingController(text: widget.initialBreed);
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _open = _focusNode.hasFocus);
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _select(String breed) {
    setState(() {
      _selected = breed;
      _query = '';
      _open = false;
    });
    _searchController.text = breed;
    _focusNode.unfocus();
    widget.onChanged(breed);
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.catName.isNotEmpty ? widget.catName : 'your cat';
    final filtered = _filtered;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What\'s $displayName\'s breed?', style: AppFonts.displayM.apply(color: AppColors.ink)),
        const Gap(8),
        Text('Not sure? Just pick the closest match.', style: AppFonts.bodyM.apply(color: AppColors.stone)),
        const Gap(24),

        // Dropdown field
        TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: AppFonts.bodyL.apply(color: AppColors.ink),
          textCapitalization: TextCapitalization.words,
          cursorColor: AppColors.lavenderDeep,
          decoration: InputDecoration(
            hintText: 'Search breeds…',
            hintStyle: AppFonts.bodyL.apply(color: AppColors.pebble),
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
                  clipBehavior: Clip.hardEdge,
                  child: filtered.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text('No breeds found', style: AppFonts.bodyM.apply(color: AppColors.stone)),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) => const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.mist),
                          itemBuilder: (context, i) {
                            final breed = filtered[i];
                            final isSelected = breed == _selected;
                            return _BreedRow(
                              breed: breed,
                              isSelected: isSelected,
                              onTap: () => _select(breed),
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

class _BreedRow extends StatelessWidget {
  const _BreedRow({required this.breed, required this.isSelected, required this.onTap});

  final String breed;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lavenderWash : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                breed,
                style: AppFonts.bodyM.apply(color: isSelected ? AppColors.lavenderDeep : AppColors.ink),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_rounded, size: 18, color: AppColors.lavenderDeep),
          ],
        ),
      ),
    );
  }
}
