import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/core/services/local_database/local_database_service.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/data/models/tip.dart';
import 'package:pet_ai_project/data/repositories/cat_repository.dart';
import 'package:pet_ai_project/data/repositories/task_repository.dart';
import 'package:pet_ai_project/data/repositories/tip_repository.dart';

import '../../../common/change_notifier/safe_change_notifier.dart';

class HomeController extends SafeChangeNotifier {
  HomeController({
    CatRepository? catRepository,
    TipRepository? tipRepository,
    TaskRepository? taskRepository,
    LocalDatabaseService? localDatabaseService,
  })  : _catRepository = catRepository ?? locator<CatRepository>(),
        _tipRepository = tipRepository ?? locator<TipRepository>(),
        _taskRepository = taskRepository ?? locator<TaskRepository>(),
        _localDatabase =
            localDatabaseService ?? locator<LocalDatabaseService>() {
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _selectedDate = _today;
  }

  final CatRepository _catRepository;
  final TipRepository _tipRepository;
  final TaskRepository _taskRepository;
  final LocalDatabaseService _localDatabase;

  Cat? _cat;
  List<Tip> _tips = const [];
  List<Task> _allTasks = const [];
  bool _loading = false;
  bool _loadingTasks = false;
  String? _taskError;
  late final DateTime _today;
  DateTime? _selectedDate;

  Cat? get cat => _cat;
  bool get loading => _loading;
  bool get loadingTasks => _loadingTasks;
  String? get taskError => _taskError;
  DateTime get today => _today;
  DateTime? get selectedDate => _selectedDate;

  List<Task> get tasksForSelectedDate {
    final day = _selectedDate ?? _today;
    return _taskRepository.tasksForDate(_allTasks, day);
  }

  List<DateTime> get currentWeekDays {
    final sunday = _today.subtract(Duration(days: _today.weekday % 7));
    return List.generate(7, (i) => sunday.add(Duration(days: i)));
  }

  void selectDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  Tip? get currentTip {
    if (_tips.isEmpty) return null;
    final rotation = _localDatabase.getTipRotation();
    final index = rotation % _tips.length;
    return _tips[index];
  }

  Future<void> load() async {
    _loading = true;
    _loadingTasks = true;
    _taskError = null;
    notifyListeners();
    final results = await Future.wait([
      _catRepository.getCurrentCat(),
      _safeLoadTips(),
      _safeLoadTasks(),
    ]);
    _cat = results[0] as Cat;
    _tips = results[1] as List<Tip>;
    _allTasks = results[2] as List<Task>;
    _loading = false;
    _loadingTasks = false;
    notifyListeners();
  }

  Future<List<Tip>> _safeLoadTips() async {
    try {
      return await _tipRepository.loadTips();
    } catch (e) {
      print('[HomeController] loadTips failed: $e');
      return const [];
    }
  }

  Future<List<Task>> _safeLoadTasks() async {
    try {
      return await _taskRepository.loadTasksWithSeed();
    } catch (e) {
      print('[HomeController] loadTasksWithSeed failed: $e');
      _taskError = e.toString();
      return const [];
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final day = _selectedDate ?? _today;
    final key = Task.dateKey(day);
    final updated = Set<String>.from(task.completedDates);
    if (updated.contains(key)) {
      updated.remove(key);
    } else {
      updated.add(key);
    }
    final newTask = task.copyWith(completedDates: updated);
    _allTasks = [
      for (final t in _allTasks) t.id == task.id ? newTask : t,
    ];
    notifyListeners();
    try {
      await _taskRepository.toggleCompletion(task, day);
    } catch (e) {
      print('[HomeController] toggleTaskCompletion failed: $e');
      _allTasks = [
        for (final t in _allTasks) t.id == task.id ? task : t,
      ];
      _taskError = e.toString();
      notifyListeners();
    }
  }

  Future<void> createTask({
    required String title,
    required TaskType type,
  }) async {
    final day = _selectedDate ?? _today;
    try {
      final task = await _taskRepository.createTask(
        title: title,
        type: type,
        selectedDate: day,
      );
      _allTasks = [..._allTasks, task];
      notifyListeners();
    } catch (e) {
      print('[HomeController] createTask failed: $e');
      _taskError = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTask(
    Task original, {
    required String title,
    required TaskType type,
    required DateTime? date,
  }) async {
    try {
      final updated = await _taskRepository.updateTask(
        original,
        title: title,
        type: type,
        date: date,
      );
      _allTasks = [
        for (final t in _allTasks) t.id == original.id ? updated : t,
      ];
      notifyListeners();
    } catch (e) {
      print('[HomeController] updateTask failed: $e');
      _taskError = e.toString();
      notifyListeners();
    }
  }

  Future<void> setTaskCompletion(Task task, bool completed) async {
    final current = _allTasks.firstWhere(
      (t) => t.id == task.id,
      orElse: () => task,
    );
    final day = _selectedDate ?? _today;
    final key = Task.dateKey(day);
    final alreadyCompleted = current.completedDates.contains(key);
    if (alreadyCompleted == completed) return;
    final updated = Set<String>.from(current.completedDates);
    if (completed) {
      updated.add(key);
    } else {
      updated.remove(key);
    }
    final newTask = current.copyWith(completedDates: updated);
    _allTasks = [
      for (final t in _allTasks) t.id == current.id ? newTask : t,
    ];
    notifyListeners();
    try {
      await _taskRepository.setCompletion(current, day, completed);
    } catch (e) {
      print('[HomeController] setTaskCompletion failed: $e');
      _allTasks = [
        for (final t in _allTasks) t.id == current.id ? current : t,
      ];
      _taskError = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTask(Task task) async {
    final snapshot = _allTasks;
    _allTasks = _allTasks.where((t) => t.id != task.id).toList();
    notifyListeners();
    try {
      await _taskRepository.deleteTask(task);
    } catch (e) {
      print('[HomeController] deleteTask failed: $e');
      _allTasks = snapshot;
      _taskError = e.toString();
      notifyListeners();
    }
  }
}
