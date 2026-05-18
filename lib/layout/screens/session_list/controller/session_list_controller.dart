import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';
import 'package:pet_ai_project/data/repositories/chat_repository.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

class SessionListController extends SafeChangeNotifier {
  SessionListController({ChatRepository? repository})
      : _repository = repository ?? locator<ChatRepository>();

  final ChatRepository _repository;

  List<ChatSession> _sessions = [];
  bool _loading = false;

  List<ChatSession> get sessions => _sessions;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _sessions = await _repository.loadSessions();
    _loading = false;
    notifyListeners();
  }

  Future<ChatSession> createSession() async {
    final session = await _repository.createSession();
    _sessions = [session, ..._sessions];
    notifyListeners();
    return session;
  }

  Future<void> deleteSession(String sessionId) async {
    await _repository.deleteSession(sessionId);
    _sessions = _sessions.where((s) => s.id != sessionId).toList();
    notifyListeners();
  }
}
