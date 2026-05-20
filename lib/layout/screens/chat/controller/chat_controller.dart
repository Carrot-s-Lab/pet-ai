import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/core/services/local_database/local_database_service.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';
import 'package:pet_ai_project/data/repositories/chat_repository.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

const _kFreeMessageLimit = 1;

class ChatController extends SafeChangeNotifier {
  ChatController({
    required this.sessionId,
    ChatRepository? repository,
    ImagePicker? imagePicker,
    LocalDatabaseService? db,
  })  : _repository = repository ?? locator<ChatRepository>(),
        _picker = imagePicker ?? ImagePicker(),
        _db = db ?? locator<LocalDatabaseService>();

  final String sessionId;
  final ChatRepository _repository;
  final ImagePicker _picker;
  final LocalDatabaseService _db;

  ChatSession? _session;
  List<ChatMessage> _messages = [];
  List<String> _pendingImagePaths = [];
  bool _loading = false;
  bool _sending = false;
  bool _loadingMore = false;
  bool _hasMore = false;
  DateTime? _oldestMessageTimestamp;
  String? _errorMessage;

  ChatSession? get session => _session;
  List<ChatMessage> get messages => _messages;
  List<String> get pendingImagePaths => _pendingImagePaths;
  bool get loading => _loading;
  bool get sending => _sending;
  bool get showTypingIndicator => _sending;
  bool get loadingMore => _loadingMore;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;
  bool get isPremium => _db.isPremium();
  bool get isLimitReached =>
      !isPremium && _db.getFreeMessageCount() >= _kFreeMessageLimit;

  Future<void> upgradeToPremium() async {
    await _db.setPremium(true);
    notifyListeners();
  }

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
    final result = await _repository.loadRecentMessages(sessionId);
    _messages = result.messages;
    _hasMore = result.hasMore;
    _oldestMessageTimestamp =
        _messages.isNotEmpty ? _messages.first.createdAt : null;
    _loading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_loadingMore || !_hasMore || _oldestMessageTimestamp == null) return;
    _loadingMore = true;
    notifyListeners();
    try {
      final result = await _repository.loadMoreMessages(
        sessionId,
        _oldestMessageTimestamp!,
      );
      _messages = [...result.messages, ..._messages];
      _hasMore = result.hasMore;
      if (result.messages.isNotEmpty) {
        _oldestMessageTimestamp = result.messages.first.createdAt;
      }
    } finally {
      _loadingMore = false;
      notifyListeners();
    }
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

    if (trimmed.isEmpty && _pendingImagePaths.isEmpty) return;
    if (_session == null) return;
    if (_sending) return;
    if (isLimitReached) return;

    _sending = true;
    _errorMessage = null;
    notifyListeners();

    final imagesToSend = List<String>.from(_pendingImagePaths);
    _pendingImagePaths = [];

    try {
      final result = await _repository.sendMessage(
        session: _session!,
        history: _messages,
        text: trimmed,
        imagePaths: imagesToSend,
      );

      _session = result.session;
      _messages = [..._messages, result.userMessage, result.assistantMessage];
      await _db.incrementFreeMessageCount();

      if (_oldestMessageTimestamp == null && _messages.isNotEmpty) {
        _oldestMessageTimestamp = _messages.first.createdAt;
        _hasMore = false;
      }
    } catch (e, st) {
      print('[ChatController] EXCEPTION: $e\n$st');
      _errorMessage = 'Failed to send message: $e';
    } finally {
      _sending = false;
      notifyListeners();
    }
  }
}
