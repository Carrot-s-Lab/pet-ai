import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_ai_project/core/services/auth/auth_service.dart';
import 'package:pet_ai_project/data/models/task.dart';

class TaskFirestoreStorage {
  TaskFirestoreStorage({
    required AuthService authService,
    FirebaseFirestore? firestore,
  })  : _auth = authService,
        _db = firestore ??
            FirebaseFirestore.instanceFor(
              app: Firebase.app(),
              databaseId: _databaseId,
            );

  final AuthService _auth;
  final FirebaseFirestore _db;
  static const String _databaseId = 'main-db';
  static const String _tag = '[TaskStorage]';

  CollectionReference<Map<String, dynamic>> _col() => _db.collection('tasks');

  String _requireUid() {
    final uid = _auth.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      throw StateError(
        'No authenticated user — AuthService.ensureSignedIn() must complete '
        'before calling Firestore methods.',
      );
    }
    return uid;
  }

  Future<List<Task>> loadTasks() async {
    await _auth.ready;
    final uid = _requireUid();
    print('$_tag loadTasks: querying tasks for uid=$uid');
    try {
      final snap = await _col()
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt')
          .get();
      final tasks = snap.docs.map(_taskFromDoc).toList();
      print('$_tag loadTasks: success. count=${tasks.length}');
      return tasks;
    } catch (e, st) {
      print('$_tag loadTasks: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  Future<void> saveTask(Task task) async {
    await _auth.ready;
    _requireUid();
    print('$_tag saveTask: id=${task.id} type=${task.type.name} '
        'title="${task.title}"');
    try {
      await _col().doc(task.id).set(_taskToFirestore(task));
      print('$_tag saveTask: success. id=${task.id}');
    } catch (e, st) {
      print('$_tag saveTask: FAILED. id=${task.id} error=$e\n$st');
      rethrow;
    }
  }

  Future<void> updateTaskFields(
    String taskId, {
    required String title,
    required TaskType type,
    required DateTime? date,
  }) async {
    await _auth.ready;
    _requireUid();
    print('$_tag updateTaskFields: id=$taskId type=${type.name} '
        'title="$title" date=${date?.toIso8601String()}');
    try {
      await _col().doc(taskId).update({
        'title': title,
        'type': type.name,
        'date': date != null ? Timestamp.fromDate(date) : null,
      });
      print('$_tag updateTaskFields: success.');
    } catch (e, st) {
      print('$_tag updateTaskFields: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  Future<void> setCompletion(
    String taskId,
    String dateKey, {
    required bool completed,
  }) async {
    await _auth.ready;
    _requireUid();
    print('$_tag setCompletion: id=$taskId dateKey=$dateKey '
        'completed=$completed');
    try {
      await _col().doc(taskId).update({
        'completedDates': completed
            ? FieldValue.arrayUnion([dateKey])
            : FieldValue.arrayRemove([dateKey]),
      });
      print('$_tag setCompletion: success.');
    } catch (e, st) {
      print('$_tag setCompletion: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    await _auth.ready;
    _requireUid();
    print('$_tag deleteTask: id=$taskId');
    try {
      await _col().doc(taskId).delete();
      print('$_tag deleteTask: success.');
    } catch (e, st) {
      print('$_tag deleteTask: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  static Task _taskFromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      type: TaskType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => TaskType.normal,
      ),
      date: (data['date'] as Timestamp?)?.toDate(),
      completedDates: ((data['completedDates'] as List?) ?? const [])
          .map((e) => e.toString())
          .toSet(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> _taskToFirestore(Task t) => {
        'userId': t.userId,
        'title': t.title,
        'type': t.type.name,
        'date': t.date != null ? Timestamp.fromDate(t.date!) : null,
        'completedDates': t.completedDates.toList(),
        'createdAt': Timestamp.fromDate(t.createdAt),
      };
}
