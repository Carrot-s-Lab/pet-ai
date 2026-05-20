import 'dart:io';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

import '../../core/services/ai/gemini_service.dart';
import '../../core/services/storage/chat_storage_service.dart';
import '../models/chat_message.dart';
import '../models/chat_session.dart';
import '../storage/chat_firestore_storage.dart';
import 'cat_repository.dart';

class ChatRepository {
  ChatRepository({
    required ChatFirestoreStorage storage,
    required GeminiService geminiService,
    required ChatStorageService chatStorageService,
    required CatRepository catRepository,
    Uuid? uuid,
  })  : _storage = storage,
        _gemini = geminiService,
        _chatStorageService = chatStorageService,
        _catRepository = catRepository,
        _uuid = uuid ?? const Uuid();

  final ChatFirestoreStorage _storage;
  final GeminiService _gemini;
  final ChatStorageService _chatStorageService;
  final CatRepository _catRepository;
  final Uuid _uuid;

  Future<List<ChatSession>> loadSessions() async {
    final sessions = await _storage.loadSessions();
    return sessions.where((s) => s.messageCount > 0).toList();
  }

  Future<({List<ChatMessage> messages, bool hasMore})> loadRecentMessages(
    String sessionId,
  ) async {
    final messages = await _storage.loadRecentMessages(sessionId);
    return (
      messages: messages,
      hasMore: messages.length >= ChatFirestoreStorage.pageSize,
    );
  }

  Future<({List<ChatMessage> messages, bool hasMore})> loadMoreMessages(
    String sessionId,
    DateTime before,
  ) async {
    final messages =
        await _storage.loadMessagesBeforeTimestamp(sessionId, before);
    return (
      messages: messages,
      hasMore: messages.length >= ChatFirestoreStorage.pageSize,
    );
  }

  /// Returns an in-memory session. The Firestore document is created only when
  /// the user actually sends the first message (via [sendMessage]). This keeps
  /// the session list clean of empty/abandoned chats.
  Future<ChatSession> createSession({String? title}) async {
    final now = DateTime.now();
    return ChatSession(
      id: _uuid.v4(),
      title: title ?? 'New Conversation',
      lastMessagePreview: '',
      lastMessageAt: now,
      messageCount: 0,
      createdAt: now,
    );
  }

  Future<void> renameSession(ChatSession session, String newTitle) async {
    final updated = session.copyWith(title: newTitle);
    await _storage.upsertSession(updated);
  }

  Future<void> deleteSession(String sessionId) =>
      _storage.deleteSession(sessionId);

  /// Reads image bytes from [imagePaths], then runs in parallel:
  ///   1. Upload bytes to Firebase Storage → download URLs
  ///   2. Request a full Gemini reply using the same bytes
  ///
  /// Awaits both before persisting the user + assistant messages to Firestore.
  Future<ChatSendResult> sendMessage({
    required ChatSession session,
    required List<ChatMessage> history,
    required String text,
    List<String> imagePaths = const [],
  }) async {
    // Read all image bytes upfront so both upload and Gemini share the same data.
    final imageBytes = await _readImageBytes(imagePaths);

    // Kick off upload immediately — runs in parallel with the Gemini request.
    final uploadFuture = imageBytes.isNotEmpty
        ? _chatStorageService.uploadImages(
            sessionId: session.id,
            imageBytes: imageBytes,
          )
        : Future.value(<String>[]);

    final now = DateTime.now();
    final userMessageId = _uuid.v4();

    final isFirstMessage = session.messageCount == 0;
    final updatedSession = session.copyWith(
      title: isFirstMessage && text.trim().isNotEmpty
          ? _titleFrom(text)
          : session.title,
      lastMessagePreview: _preview(text),
      lastMessageAt: now,
      messageCount: session.messageCount + 1,
    );

    // Fetch the configured system instruction (falls back to the hardcoded
    // default inside GeminiService if missing or fails to load).
    String? systemInstruction;
    try {
      systemInstruction = await _storage.loadAiSystemInstruction();
    } catch (e) {
      print('[ChatRepo] loadAiSystemInstruction failed, using default. error=$e');
      systemInstruction = null;
    }

    // Substitute {{CAT_*}} placeholders in the instruction with the current
    // cat's profile data. A profile-fetch failure must not block chat — fall
    // back to the un-rendered instruction in that case.
    if (systemInstruction != null && systemInstruction.trim().isNotEmpty) {
      try {
        final cat = await _catRepository.getCurrentCat();
        if (cat != null) systemInstruction = cat.renderInto(systemInstruction);
      } catch (e) {
        print('[ChatRepo] cat profile fetch failed, sending un-rendered prompt. error=$e');
      }
    }

    // Build the user message (local paths for display during this session).
    final userMessage = ChatMessage(
      id: userMessageId,
      sessionId: session.id,
      role: ChatMessageRole.user,
      content: text,
      imagePaths: imagePaths,
      status: ChatMessageStatus.sent,
      createdAt: now,
    );

    String replyContent = '';
    var replyFailed = false;
    try {
      replyContent = await _gemini.generateReply(
        history: history,
        prompt: text,
        imagePaths: imagePaths,
        systemInstruction: systemInstruction,
      );
    } catch (e) {
      print('[ChatRepo] generateReply failed: $e');
      replyFailed = true;
    }

    final imageUrls = await uploadFuture;
    final persistedUserMessage = userMessage.copyWith(imageUrls: imageUrls);
    await _storage.saveMessage(persistedUserMessage);
    await _storage.upsertSession(updatedSession);
    print('[ChatRepo] user message saved. id=${userMessage.id} urls=${imageUrls.length}');

    final assistantMessage = ChatMessage(
      id: _uuid.v4(),
      sessionId: session.id,
      role: ChatMessageRole.assistant,
      content: replyContent.isEmpty
          ? 'Sorry, I\'m unable to respond right now.'
          : replyContent,
      status: replyFailed ? ChatMessageStatus.failed : ChatMessageStatus.sent,
      createdAt: DateTime.now(),
    );

    final finalSession = updatedSession.copyWith(
      lastMessagePreview: _preview(assistantMessage.content),
      lastMessageAt: assistantMessage.createdAt,
      messageCount: updatedSession.messageCount + 1,
    );
    await _storage.saveMessage(assistantMessage);
    await _storage.upsertSession(finalSession);
    print('[ChatRepo] assistant message saved. status=${assistantMessage.status}');

    return ChatSendResult(
      session: finalSession,
      userMessage: persistedUserMessage,
      assistantMessage: assistantMessage,
    );
  }

  Future<List<Uint8List>> _readImageBytes(List<String> paths) async {
    final results = <Uint8List>[];
    for (final path in paths) {
      final file = File(path);
      if (await file.exists()) {
        results.add(await file.readAsBytes());
      }
    }
    return results;
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

