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

  static const _breedImages = {
    'Mixed / Unknown': 'assets/images/cat_breed_mixed_unknown.png',
    'Domestic Shorthair': 'assets/images/cat_breed_domestic_shorthair.png',
    'Domestic Longhair': 'assets/images/cat_breed_domestic_longhair.png',
    'Domestic Medium Hair': 'assets/images/cat_breed_domestic_medium_hair.png',
    'Abyssinian': 'assets/images/cat_breed_abyssinian.png',
    'American Curl': 'assets/images/cat_breed_american_curl.png',
    'American Shorthair': 'assets/images/cat_breed_american_shorthair.png',
    'Bengal': 'assets/images/cat_breed_bengal.png',
    'Birman': 'assets/images/cat_breed_birman.png',
    'British Shorthair': 'assets/images/cat_breed_british_shorthair.png',
    'Burmese': 'assets/images/cat_breed_burmese.png',
    'Chartreux': 'assets/images/cat_breed_chartreux.png',
    'Cornish Rex': 'assets/images/cat_breed_cornish_rex.png',
    'Devon Rex': 'assets/images/cat_breed_devon_rex.png',
    'Egyptian Mau': 'assets/images/cat_breed_egyptian_mau.png',
    'Exotic Shorthair': 'assets/images/cat_breed_exotic_shorthair.png',
    'Himalayan': 'assets/images/cat_breed_himalayan.png',
    'Maine Coon': 'assets/images/cat_breed_maine_coon.png',
    'Manx': 'assets/images/cat_breed_manx.png',
    'Norwegian Forest Cat': 'assets/images/cat_breed_norwegian_forest_cat.png',
    'Oriental Shorthair': 'assets/images/cat_breed_oriental_shorthair.png',
    'Persian': 'assets/images/cat_breed_persian.png',
    'Ragdoll': 'assets/images/cat_breed_ragdoll.png',
    'Russian Blue': 'assets/images/cat_breed_russian_blue.png',
    'Savannah': 'assets/images/cat_breed_savannah.png',
    'Scottish Fold': 'assets/images/cat_breed_scottish_fold.png',
    'Siamese': 'assets/images/cat_breed_siamese.png',
    'Siberian': 'assets/images/cat_breed_siberian.png',
    'Somali': 'assets/images/cat_breed_somali.png',
    'Sphynx': 'assets/images/cat_breed_sphynx.png',
    'Tonkinese': 'assets/images/cat_breed_tonkinese.png',
    'Turkish Angora': 'assets/images/cat_breed_turkish_angora.png',
  };

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
    final selectedImage = _selected.isNotEmpty ? _breedImages[_selected] : null;

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
            prefixIcon: selectedImage != null && !_open
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: ClipOval(
                      child: Image.asset(selectedImage, width: 32, height: 32, fit: BoxFit.cover),
                    ),
                  )
                : const Icon(Icons.search_rounded, color: AppColors.lavenderDeep, size: 20),
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
                  height: filtered.isEmpty ? null : (filtered.length * 60.0).clamp(0, 280),
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
                          separatorBuilder: (_, _) => const Divider(height: 1, indent: 68, endIndent: 16, color: AppColors.mist),
                          itemBuilder: (context, i) {
                            final breed = filtered[i];
                            return _BreedRow(
                              breed: breed,
                              imagePath: _breedImages[breed],
                              isSelected: breed == _selected,
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
  const _BreedRow({
    required this.breed,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String breed;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: isSelected ? AppColors.lavenderWash : Colors.transparent,
        child: Row(
          children: [
            if (imagePath != null)
              ClipOval(
                child: Image.asset(
                  imagePath!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            const Gap(12),
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
