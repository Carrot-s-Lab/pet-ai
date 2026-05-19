import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

import '../../../data/models/chat_message.dart';
import '../auth/auth_service.dart';

class GeminiService {
  static const _modelName = 'gemini-2.5-flash';
  static const _systemInstruction =
      'You are a pet health consultant. Reply in English using clear markdown format '
      '(headings, bullets, bold when appropriate). '
      'For serious or persistent symptoms, always recommend the user take their pet to a veterinarian. '
      'Do not provide final medical diagnoses in place of a specialist.';

  static const int _historyLimit = 20;

  final AuthService _auth;
  late final GenerativeModel _model;

  GeminiService({required AuthService authService}) : _auth = authService {
    _model = FirebaseAI.googleAI().generativeModel(
      model: _modelName,
      systemInstruction: Content.system(_systemInstruction),
    );
  }

  Stream<String> generateReplyStream({
    required List<ChatMessage> history,
    required String prompt,
    List<String> imagePaths = const [],
  }) async* {
    await _auth.ready;
    print('[GeminiService] generateReplyStream start. historyIn=${history.length} images=${imagePaths.length}');

    final recentHistory = history.length > _historyLimit
        ? history.sublist(history.length - _historyLimit)
        : history;

    final geminiHistory = recentHistory.map(_toContent).toList();
    final chat = _model.startChat(history: geminiHistory);

    final parts = <Part>[TextPart(prompt)];
    for (final path in imagePaths) {
      final bytes = await _readImage(path);
      if (bytes != null) {
        parts.add(InlineDataPart('image/jpeg', bytes));
      }
    }

    print('[GeminiService] streaming to Gemini. parts=${parts.length}');
    try {
      final stream = chat.sendMessageStream(Content.multi(parts));
      await for (final chunk in stream) {
        final text = chunk.text ?? '';
        if (text.isNotEmpty) yield text;
      }
      print('[GeminiService] stream complete');
    } catch (e, st) {
      print('[GeminiService] sendMessageStream FAILED: $e\n$st');
      rethrow;
    }
  }

  Content _toContent(ChatMessage message) {
    final role =
        message.role == ChatMessageRole.assistant ? 'model' : 'user';
    return Content(role, [TextPart(message.content)]);
  }

  Future<Uint8List?> _readImage(String path) async {
    final file = File(path);
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }
}
