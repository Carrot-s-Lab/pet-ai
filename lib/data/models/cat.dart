class Cat {
  final String name;
  final String photoUrl;
  final int ageYears;
  final int ageMonths;
  final String sex;
  final String breed;
  final List<String> specialConditions;

  const Cat({
    required this.name,
    required this.photoUrl,
    required this.ageYears,
    required this.ageMonths,
    required this.sex,
    required this.breed,
    required this.specialConditions,
  });

  // TODO: replace with real cat data loaded from Firestore once the
  // profile screen / onboarding flow exists.
  factory Cat.sample() => const Cat(
    name: 'Miu',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pet-ai-8ceb9.firebasestorage.app/o/cat_images%2F1000057329.jpg?alt=media&token=f90c3e12-6662-4edf-9f5c-40d9f5f24a3c',
    ageYears: 2,
    ageMonths: 3,
    sex: 'female',
    breed: 'British Shorthair',
    specialConditions: ['mild allergy'],
  );

  String get formattedAge {
    final parts = <String>[];
    if (ageYears > 0) {
      parts.add('$ageYears ${ageYears == 1 ? 'year' : 'years'}');
    }
    if (ageMonths > 0) {
      parts.add('$ageMonths ${ageMonths == 1 ? 'month' : 'months'}');
    }
    return parts.isEmpty ? 'unknown' : parts.join(' ');
  }

  String get formattedConditions =>
      specialConditions.isEmpty ? 'none' : specialConditions.join(', ');

  String renderInto(String template) {
    return template
        .replaceAll('{{CAT_NAME}}', name)
        .replaceAll('{{CAT_BREED}}', breed)
        .replaceAll('{{CAT_AGE}}', formattedAge)
        .replaceAll('{{CAT_SEX}}', sex)
        .replaceAll('{{CAT_CONDITIONS}}', formattedConditions);
  }
}
