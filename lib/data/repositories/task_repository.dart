import 'package:uuid/uuid.dart';

import '../../core/services/auth/auth_service.dart';
import '../models/task.dart';
import '../storage/task_firestore_storage.dart';

class TaskRepository {
  TaskRepository({
    required TaskFirestoreStorage storage,
    required AuthService auth,
    Uuid? uuid,
  })  : _storage = storage,
        _auth = auth,
        _uuid = uuid ?? const Uuid();

  final TaskFirestoreStorage _storage;
  final AuthService _auth;
  final Uuid _uuid;

  static const List<String> _defaultDailyTitles = [
    'Feed the cat',
    'Brush cat fur',
    'Play with cat',
  ];

  Future<List<Task>> loadTasksWithSeed() async {
    final tasks = await _storage.loadTasks();
    final hasDaily = tasks.any((t) => t.type == TaskType.daily);
    if (!hasDaily) {
      final seeded = await _seedDefaultDaily();
      return [...seeded, ...tasks];
    }
    return tasks;
  }

  Future<List<Task>> _seedDefaultDaily() async {
    await _auth.ready;
    final uid = _auth.currentUser!.uid;
    final now = DateTime.now();
    final seeded = <Task>[];
    for (var i = 0; i < _defaultDailyTitles.length; i++) {
      final task = Task(
        id: _uuid.v4(),
        userId: uid,
        title: _defaultDailyTitles[i],
        type: TaskType.daily,
        completedDates: const {},
        createdAt: now.add(Duration(milliseconds: i)),
      );
      await _storage.saveTask(task);
      seeded.add(task);
    }
    return seeded;
  }

  List<Task> tasksForDate(List<Task> all, DateTime day) {
    final key = Task.dateKey(day);
    return all.where((t) {
      if (t.type == TaskType.daily) return true;
      return t.date != null && Task.dateKey(t.date!) == key;
    }).toList();
  }

  Future<void> toggleCompletion(Task task, DateTime day) async {
    final key = Task.dateKey(day);
    final wasCompleted = task.completedDates.contains(key);
    await _storage.setCompletion(task.id, key, completed: !wasCompleted);
  }

  Future<Task> createTask({
    required String title,
    required TaskType type,
    required DateTime selectedDate,
  }) async {
    await _auth.ready;
    final uid = _auth.currentUser!.uid;
    final task = Task(
      id: _uuid.v4(),
      userId: uid,
      title: title.trim(),
      type: type,
      date: type == TaskType.normal
          ? DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
          : null,
      completedDates: const {},
      createdAt: DateTime.now(),
    );
    await _storage.saveTask(task);
    return task;
  }

  Future<Task> updateTask(
    Task original, {
    required String title,
    required TaskType type,
    required DateTime? date,
  }) async {
    final normalizedDate = type == TaskType.normal && date != null
        ? DateTime(date.year, date.month, date.day)
        : null;
    await _storage.updateTaskFields(
      original.id,
      title: title.trim(),
      type: type,
      date: normalizedDate,
    );
    return Task(
      id: original.id,
      userId: original.userId,
      title: title.trim(),
      type: type,
      date: normalizedDate,
      completedDates: original.completedDates,
      createdAt: original.createdAt,
    );
  }

  Future<void> deleteTask(Task task) => _storage.deleteTask(task.id);

  Future<void> setCompletion(Task task, DateTime day, bool completed) {
    return _storage.setCompletion(
      task.id,
      Task.dateKey(day),
      completed: completed,
    );
  }
}
