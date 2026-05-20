// ignore_for_file: avoid_dynamic_calls
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

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
    name: json['name'] as String? ?? '',
    photoUrl: json['photoUrl'] as String? ?? '',
    ageYears: json['ageYears'] as int? ?? 0,
    ageMonths: json['ageMonths'] as int? ?? 0,
    sex: json['sex'] as String? ?? '',
    breed: json['breed'] as String? ?? '',
    specialConditions: (json['specialConditions'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        const [],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'photoUrl': photoUrl,
    'ageYears': ageYears,
    'ageMonths': ageMonths,
    'sex': sex,
    'breed': breed,
    'specialConditions': specialConditions,
  };

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
