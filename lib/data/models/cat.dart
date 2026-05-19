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
        photoUrl: '',
        ageYears: 2,
        ageMonths: 3,
        sex: 'female',
        breed: 'British Shorthair',
        specialConditions: ['mild allergy'],
      );

  String get _formattedAge {
    final parts = <String>[];
    if (ageYears > 0) {
      parts.add('$ageYears ${ageYears == 1 ? 'year' : 'years'}');
    }
    if (ageMonths > 0) {
      parts.add('$ageMonths ${ageMonths == 1 ? 'month' : 'months'}');
    }
    return parts.join(' ');
  }

  String get _formattedConditions =>
      specialConditions.isEmpty ? 'none' : specialConditions.join(', ');

  String renderInto(String template) {
    return template
        .replaceAll('{{CAT_NAME}}', name)
        .replaceAll('{{CAT_BREED}}', breed)
        .replaceAll('{{CAT_AGE}}', _formattedAge)
        .replaceAll('{{CAT_SEX}}', sex)
        .replaceAll('{{CAT_CONDITIONS}}', _formattedConditions);
  }
}
