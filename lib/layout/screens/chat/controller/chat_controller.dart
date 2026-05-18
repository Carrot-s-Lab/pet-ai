import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';
import 'package:pet_ai_project/data/repositories/chat_repository.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

class ChatController extends SafeChangeNotifier {
  ChatController({
    required this.sessionId,
    ChatRepository? repository,
    ImagePicker? imagePicker,
  })  : _repository = repository ?? locator<ChatRepository>(),
        _picker = imagePicker ?? ImagePicker();

  final String sessionId;
  final ChatRepository _repository;
  final ImagePicker _picker;

  ChatSession? _session;
  List<ChatMessage> _messages = [];
  List<String> _pendingImagePaths = [];
  bool _loading = false;
  bool _sending = false;
  String? _errorMessage;

  ChatSession? get session => _session;
  List<ChatMessage> get messages => _messages;
  List<String> get pendingImagePaths => _pendingImagePaths;
  bool get loading => _loading;
  bool get sending => _sending;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    final sessions = await _repository.loadSessions();
    _session = sessions.firstWhere(
      (s) => s.id == sessionId,
      orElse: () => ChatSession(
        id: sessionId,
        title: 'Conversation',
        lastMessagePreview: '',
        lastMessageAt: DateTime.now(),
        messageCount: 0,
        createdAt: DateTime.now(),
      ),
    );
    _messages = await _repository.loadMessages(sessionId);
    _loading = false;
    notifyListeners();
  }

  Future<void> pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;
    _pendingImagePaths = [..._pendingImagePaths, ...picked.map((x) => x.path)];
    notifyListeners();
  }

  void removePendingImage(String path) {
    _pendingImagePaths = _pendingImagePaths.where((p) => p != path).toList();
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    print('[ChatController] sendMessage called. text="$trimmed" images=${_pendingImagePaths.length}');

    if (trimmed.isEmpty && _pendingImagePaths.isEmpty) {
      print('[ChatController] aborted: empty text and no images');
      return;
    }
    if (_session == null) {
      print('[ChatController] aborted: session is null');
      return;
    }
    if (_sending) {
      print('[ChatController] aborted: already sending');
      return;
    }

    _sending = true;
    _errorMessage = null;
    notifyListeners();

    final imagesToSend = List<String>.from(_pendingImagePaths);
    _pendingImagePaths = [];
    print('[ChatController] session.id=${_session!.id} history.length=${_messages.length}');

    try {
      print('[ChatController] calling repository.sendMessage...');
      final result = await _repository.sendMessage(
        session: _session!,
        history: _messages,
        text: trimmed,
        imagePaths: imagesToSend,
      );
      print('[ChatController] done. assistantStatus=${result.assistantMessage.status} error=${result.assistantMessage.errorMessage}');
      _session = result.session;
      _messages = [..._messages, result.userMessage, result.assistantMessage];
    } catch (e, st) {
      print('[ChatController] EXCEPTION: $e\n$st');
      _errorMessage = 'Failed to send message: $e';
    } finally {
      _sending = false;
      notifyListeners();
    }
  }
}
