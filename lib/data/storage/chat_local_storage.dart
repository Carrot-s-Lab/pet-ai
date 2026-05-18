import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_message.dart';
import '../models/chat_session.dart';

class ChatLocalStorage {
  static const _sessionsKey = 'chat_sessions';
  static const _messagesKeyPrefix = 'chat_messages_';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  String _messagesKey(String sessionId) => '$_messagesKeyPrefix$sessionId';

  Future<List<ChatSession>> loadSessions() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_sessionsKey);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List;
    final sessions = list
        .map((e) => ChatSession.fromJson(e as Map<String, dynamic>))
        .toList();
    sessions.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return sessions;
  }

  Future<void> saveSessions(List<ChatSession> sessions) async {
    final prefs = await _prefs;
    final encoded = jsonEncode(sessions.map((e) => e.toJson()).toList());
    await prefs.setString(_sessionsKey, encoded);
  }

  Future<void> upsertSession(ChatSession session) async {
    final sessions = await loadSessions();
    final index = sessions.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.add(session);
    }
    await saveSessions(sessions);
  }

  Future<void> deleteSession(String sessionId) async {
    final sessions = await loadSessions();
    sessions.removeWhere((s) => s.id == sessionId);
    await saveSessions(sessions);
    final prefs = await _prefs;
    await prefs.remove(_messagesKey(sessionId));
  }

  Future<List<ChatMessage>> loadMessages(String sessionId) async {
    final prefs = await _prefs;
    final raw = prefs.getString(_messagesKey(sessionId));
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List;
    final messages = list
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList();
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return messages;
  }

  Future<void> saveMessages(
    String sessionId,
    List<ChatMessage> messages,
  ) async {
    final prefs = await _prefs;
    final encoded = jsonEncode(messages.map((e) => e.toJson()).toList());
    await prefs.setString(_messagesKey(sessionId), encoded);
  }

  Future<void> appendMessage(ChatMessage message) async {
    final messages = await loadMessages(message.sessionId);
    messages.add(message);
    await saveMessages(message.sessionId, messages);
  }

  Future<void> updateMessage(ChatMessage message) async {
    final messages = await loadMessages(message.sessionId);
    final index = messages.indexWhere((m) => m.id == message.id);
    if (index >= 0) {
      messages[index] = message;
      await saveMessages(message.sessionId, messages);
    }
  }
}
