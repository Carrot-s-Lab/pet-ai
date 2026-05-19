import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_ai_project/core/services/auth/auth_service.dart';
import 'package:pet_ai_project/data/models/chat_message.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';

class ChatFirestoreStorage {
  ChatFirestoreStorage({
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
  static const String _databaseId = 'chat-db';
  static const int pageSize = 20;
  static const String _tag = '[FirestoreStorage]';

  CollectionReference<Map<String, dynamic>> _sessionsCol() =>
      _db.collection('chat_sessions');

  DocumentReference<Map<String, dynamic>> _sessionDoc(String sessionId) =>
      _sessionsCol().doc(sessionId);

  CollectionReference<Map<String, dynamic>> _messagesCol(String sessionId) =>
      _sessionDoc(sessionId).collection('messages');

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

  // ── Sessions ──────────────────────────────────────────────────────────────

  Future<List<ChatSession>> loadSessions() async {
    await _auth.ready;
    final uid = _requireUid();
    print('$_tag loadSessions: querying chat_sessions for uid=$uid '
        'ordered by lastMessageAt desc');
    try {
      final snap = await _sessionsCol()
          .where('userId', isEqualTo: uid)
          .orderBy('lastMessageAt', descending: true)
          .get();
      final sessions = snap.docs.map(_sessionFromDoc).toList();
      print('$_tag loadSessions: success. count=${sessions.length}');
      return sessions;
    } catch (e, st) {
      print('$_tag loadSessions: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  Future<void> upsertSession(ChatSession session) async {
    await _auth.ready;
    final uid = _requireUid();
    print('$_tag upsertSession: id=${session.id} uid=$uid title="${session.title}" '
        'messageCount=${session.messageCount}');
    try {
      await _sessionDoc(session.id).set({
        ..._sessionToFirestore(session),
        'userId': uid,
      });
      print('$_tag upsertSession: success. id=${session.id}');
    } catch (e, st) {
      print('$_tag upsertSession: FAILED. id=${session.id} error=$e\n$st');
      rethrow;
    }
  }

  Future<void> deleteSession(String sessionId) async {
    await _auth.ready;
    print('$_tag deleteSession: sessionId=$sessionId');
    try {
      final msgDocs = await _messagesCol(sessionId).get();
      print('$_tag deleteSession: found ${msgDocs.docs.length} messages to delete');

      var batch = _db.batch();
      var batchCount = 0;
      var totalCommitted = 0;

      for (final doc in msgDocs.docs) {
        batch.delete(doc.reference);
        batchCount++;
        if (batchCount == 499) {
          await batch.commit();
          totalCommitted += batchCount;
          print('$_tag deleteSession: chunked commit. cumulative=$totalCommitted');
          batch = _db.batch();
          batchCount = 0;
        }
      }

      batch.delete(_sessionDoc(sessionId));
      await batch.commit();
      print('$_tag deleteSession: success. sessionId=$sessionId '
          'totalMessagesDeleted=${msgDocs.docs.length}');
    } catch (e, st) {
      print('$_tag deleteSession: FAILED. sessionId=$sessionId error=$e\n$st');
      rethrow;
    }
  }

  // ── Messages ──────────────────────────────────────────────────────────────

  Future<List<ChatMessage>> loadRecentMessages(String sessionId) async {
    await _auth.ready;
    print('$_tag loadRecentMessages: sessionId=$sessionId limit=$pageSize');
    try {
      final snap = await _messagesCol(sessionId)
          .orderBy('createdAt', descending: true)
          .limit(pageSize)
          .get();
      final messages = snap.docs.map(_messageFromDoc).toList();
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      print('$_tag loadRecentMessages: success. count=${messages.length} '
          'oldest=${messages.isNotEmpty ? messages.first.createdAt.toIso8601String() : "n/a"} '
          'newest=${messages.isNotEmpty ? messages.last.createdAt.toIso8601String() : "n/a"}');
      return messages;
    } catch (e, st) {
      print('$_tag loadRecentMessages: FAILED. sessionId=$sessionId error=$e\n$st');
      rethrow;
    }
  }

  Future<List<ChatMessage>> loadMessagesBeforeTimestamp(
    String sessionId,
    DateTime before,
  ) async {
    await _auth.ready;
    print('$_tag loadMessagesBeforeTimestamp: sessionId=$sessionId '
        'before=${before.toIso8601String()} limit=$pageSize');
    try {
      final snap = await _messagesCol(sessionId)
          .where('createdAt', isLessThan: Timestamp.fromDate(before))
          .orderBy('createdAt', descending: true)
          .limit(pageSize)
          .get();
      final messages = snap.docs.map(_messageFromDoc).toList();
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      print('$_tag loadMessagesBeforeTimestamp: success. count=${messages.length} '
          'oldest=${messages.isNotEmpty ? messages.first.createdAt.toIso8601String() : "n/a"} '
          'newest=${messages.isNotEmpty ? messages.last.createdAt.toIso8601String() : "n/a"}');
      return messages;
    } catch (e, st) {
      print('$_tag loadMessagesBeforeTimestamp: FAILED. sessionId=$sessionId error=$e\n$st');
      rethrow;
    }
  }

  Future<void> saveMessage(ChatMessage message) async {
    await _auth.ready;
    print('$_tag saveMessage: id=${message.id} sessionId=${message.sessionId} '
        'role=${message.role.name} status=${message.status.name} '
        'contentLen=${message.content.length} imageUrls=${message.imageUrls.length}');
    try {
      await _messagesCol(message.sessionId)
          .doc(message.id)
          .set(_messageToFirestore(message));
      print('$_tag saveMessage: success. id=${message.id}');
    } catch (e, st) {
      print('$_tag saveMessage: FAILED. id=${message.id} error=$e\n$st');
      rethrow;
    }
  }

  // ── Config ────────────────────────────────────────────────────────────────

  /// Reads the AI system instruction from `config/ai`. Returns null when the
  /// doc or field is missing — the caller decides what to fall back to.
  Future<String?> loadAiSystemInstruction() async {
    await _auth.ready;
    print('$_tag loadAiSystemInstruction: reading config/ai');
    try {
      final snap = await _db.collection('config').doc('ai').get();
      if (!snap.exists) {
        print('$_tag loadAiSystemInstruction: doc not found');
        return null;
      }
      final value = snap.data()?['systemInstruction'] as String?;
      print('$_tag loadAiSystemInstruction: success. len=${value?.length ?? 0}');
      return value;
    } catch (e, st) {
      print('$_tag loadAiSystemInstruction: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  // ── Firestore <-> Model converters ────────────────────────────────────────

  static ChatSession _sessionFromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatSession(
      id: doc.id,
      title: data['title'] as String? ?? '',
      lastMessagePreview: data['lastMessagePreview'] as String? ?? '',
      lastMessageAt: (data['lastMessageAt'] as Timestamp).toDate(),
      messageCount: data['messageCount'] as int? ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> _sessionToFirestore(ChatSession s) => {
        'title': s.title,
        'lastMessagePreview': s.lastMessagePreview,
        'lastMessageAt': Timestamp.fromDate(s.lastMessageAt),
        'messageCount': s.messageCount,
        'createdAt': Timestamp.fromDate(s.createdAt),
      };

  static ChatMessage _messageFromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      sessionId: data['sessionId'] as String,
      role: ChatMessageRole.values.firstWhere(
        (e) => e.name == data['role'],
        orElse: () => ChatMessageRole.user,
      ),
      content: data['content'] as String? ?? '',
      imagePaths: const [],
      imageUrls:
          (data['imageUrls'] as List?)?.map((e) => e.toString()).toList() ??
              const [],
      status: ChatMessageStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => ChatMessageStatus.sent,
      ),
      errorMessage: data['errorMessage'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> _messageToFirestore(ChatMessage m) => {
        'sessionId': m.sessionId,
        'role': m.role.name,
        'content': m.content,
        'imageUrls': m.imageUrls,
        'status': m.status.name,
        'errorMessage': m.errorMessage,
        'createdAt': Timestamp.fromDate(m.createdAt),
      };
}
