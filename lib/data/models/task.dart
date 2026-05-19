enum TaskType { daily, normal }

class Task {
  const Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.completedDates,
    required this.createdAt,
    this.date,
  });

  final String id;
  final String userId;
  final String title;
  final TaskType type;
  final DateTime? date;
  final Set<String> completedDates;
  final DateTime createdAt;

  bool isCompletedOn(DateTime day) => completedDates.contains(dateKey(day));

  Task copyWith({
    String? title,
    TaskType? type,
    DateTime? date,
    Set<String>? completedDates,
  }) {
    return Task(
      id: id,
      userId: userId,
      title: title ?? this.title,
      type: type ?? this.type,
      date: date ?? this.date,
      completedDates: completedDates ?? this.completedDates,
      createdAt: createdAt,
    );
  }

  static String dateKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
