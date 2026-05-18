import 'package:uuid/uuid.dart';

import '../../core/services/ai/gemini_service.dart';
import '../models/chat_message.dart';
import '../models/chat_session.dart';
import '../storage/chat_local_storage.dart';

class ChatRepository {
  ChatRepository({
    required ChatLocalStorage storage,
    required GeminiService geminiService,
    Uuid? uuid,
  })  : _storage = storage,
        _gemini = geminiService,
        _uuid = uuid ?? const Uuid();

  final ChatLocalStorage _storage;
  final GeminiService _gemini;
  final Uuid _uuid;

  Future<List<ChatSession>> loadSessions() => _storage.loadSessions();

  Future<List<ChatMessage>> loadMessages(String sessionId) =>
      _storage.loadMessages(sessionId);

  Future<ChatSession> createSession({String? title}) async {
    final now = DateTime.now();
    final session = ChatSession(
      id: _uuid.v4(),
      title: title ?? 'New Conversation',
      lastMessagePreview: '',
      lastMessageAt: now,
      messageCount: 0,
      createdAt: now,
    );
    await _storage.upsertSession(session);
    return session;
  }

  Future<void> renameSession(ChatSession session, String newTitle) async {
    final updated = session.copyWith(title: newTitle);
    await _storage.upsertSession(updated);
  }

  Future<void> deleteSession(String sessionId) =>
      _storage.deleteSession(sessionId);

  /// Sends a user message and returns the updated session + new messages
  /// (user message + assistant reply).
  Future<ChatSendResult> sendMessage({
    required ChatSession session,
    required List<ChatMessage> history,
    required String text,
    List<String> imagePaths = const [],
  }) async {
    print('[ChatRepo] step 1 - saving user message. sessionId=${session.id}');
    final now = DateTime.now();
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      sessionId: session.id,
      role: ChatMessageRole.user,
      content: text,
      imagePaths: imagePaths,
      status: ChatMessageStatus.sent,
      createdAt: now,
    );
    await _storage.appendMessage(userMessage);
    print('[ChatRepo] step 1 - user message saved. id=${userMessage.id}');

    final isFirstMessage = session.messageCount == 0;
    final preview = _preview(text);
    var updatedSession = session.copyWith(
      title: isFirstMessage && text.trim().isNotEmpty
          ? _titleFrom(text)
          : session.title,
      lastMessagePreview: preview,
      lastMessageAt: now,
      messageCount: session.messageCount + 1,
    );
    await _storage.upsertSession(updatedSession);
    print('[ChatRepo] step 2 - session metadata updated. messageCount=${updatedSession.messageCount}');

    ChatMessage assistantMessage;
    try {
      print('[ChatRepo] step 3 - calling GeminiService. historyCount=${history.length} images=${imagePaths.length}');
      final reply = await _gemini.generateReply(
        history: history,
        prompt: text,
        imagePaths: imagePaths,
      );
      print('[ChatRepo] step 3 - Gemini replied. replyLength=${reply.length}');
      assistantMessage = ChatMessage(
        id: _uuid.v4(),
        sessionId: session.id,
        role: ChatMessageRole.assistant,
        content: reply.isEmpty
            ? 'Sorry, I\'m unable to respond right now.'
            : reply,
        status: ChatMessageStatus.sent,
        createdAt: DateTime.now(),
      );
    } catch (e, st) {
      print('[ChatRepo] step 3 - Gemini FAILED: $e\n$st');
      assistantMessage = ChatMessage(
        id: _uuid.v4(),
        sessionId: session.id,
        role: ChatMessageRole.assistant,
        content: 'An error occurred while calling AI. Please try again.',
        status: ChatMessageStatus.failed,
        errorMessage: e.toString(),
        createdAt: DateTime.now(),
      );
    }
    print('[ChatRepo] step 4 - saving assistant message. status=${assistantMessage.status}');
    await _storage.appendMessage(assistantMessage);

    final replyTime = assistantMessage.createdAt;
    updatedSession = updatedSession.copyWith(
      lastMessagePreview: _preview(assistantMessage.content),
      lastMessageAt: replyTime,
      messageCount: updatedSession.messageCount + 1,
    );
    await _storage.upsertSession(updatedSession);

    return ChatSendResult(
      session: updatedSession,
      userMessage: userMessage,
      assistantMessage: assistantMessage,
    );
  }

  String _preview(String text) {
    final trimmed = text.trim().replaceAll(RegExp(r'\s+'), ' ');
    return trimmed.length > 100 ? trimmed.substring(0, 100) : trimmed;
  }

  String _titleFrom(String text) {
    final trimmed = text.trim().replaceAll(RegExp(r'\s+'), ' ');
    return trimmed.length > 40 ? '${trimmed.substring(0, 40)}…' : trimmed;
  }
}

class ChatSendResult {
  final ChatSession session;
  final ChatMessage userMessage;
  final ChatMessage assistantMessage;

  const ChatSendResult({
    required this.session,
    required this.userMessage,
    required this.assistantMessage,
  });
}
