import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

// 2 rows × 104 px card + 8 px gap
const _kGridHeight = 216.0;

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
  String _query = '';
  late String _selected;

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
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _select(String breed) {
    setState(() => _selected = breed);
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
        const Gap(20),

        TextField(
          controller: _searchController,
          style: AppFonts.bodyM.apply(color: AppColors.ink),
          cursorColor: AppColors.lavenderDeep,
          decoration: InputDecoration(
            hintText: 'Search breeds…',
            hintStyle: AppFonts.bodyM.apply(color: AppColors.pebble),
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.lavenderDeep, size: 20),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.pebble),
                    onPressed: () {
                      setState(() => _query = '');
                      _searchController.clear();
                    },
                  )
                : null,
            fillColor: AppColors.lavenderWash,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.lavenderDeep, width: 1.5),
            ),
          ),
          onChanged: (v) => setState(() => _query = v),
        ),

        const Gap(12),

        if (filtered.isEmpty)
          Center(child: Text('No breeds found', style: AppFonts.bodyM.apply(color: AppColors.stone)))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final breed = filtered[i];
              return _BreedCard(
                breed: breed,
                imagePath: _breedImages[breed] ?? 'assets/images/cat_breed_mixed_unknown.png',
                isSelected: _selected == breed,
                onTap: () => _select(breed),
              );
            },
          ),
      ],
    );
  }
}

class _BreedCard extends StatelessWidget {
  const _BreedCard({
    required this.breed,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String breed;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.lavenderDeep : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.lavenderDeep.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 16, 4, 6),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xCC000000), Colors.transparent],
                    ),
                  ),
                  child: Text(
                    breed,
                    style: AppFonts.captionS.apply(color: AppColors.appWhite),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.lavenderDeep,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded, size: 13, color: AppColors.appWhite),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
