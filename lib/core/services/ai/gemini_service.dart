import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

import '../../../data/models/chat_message.dart';
import '../auth/auth_service.dart';

class GeminiService {
  static const _modelName = 'gemini-2.5-flash';
  static const _defaultSystemInstruction =
      'You are a pet health consultant. Reply in English using clear markdown format '
      '(headings, bullets, bold when appropriate). '
      'For serious or persistent symptoms, always recommend the user take their pet to a veterinarian. '
      'Do not provide final medical diagnoses in place of a specialist.';

  static const int _historyLimit = 20;

  final AuthService _auth;

  GeminiService({required AuthService authService}) : _auth = authService;

  GenerativeModel _buildModel(String? systemInstruction) {
    final instruction =
        (systemInstruction == null || systemInstruction.trim().isEmpty)
            ? _defaultSystemInstruction
            : systemInstruction;
    return FirebaseAI.googleAI().generativeModel(
      model: _modelName,
      systemInstruction: Content.system(instruction),
    );
  }

  Future<String> generateReply({
    required List<ChatMessage> history,
    required String prompt,
    List<String> imagePaths = const [],
    String? systemInstruction,
  }) async {
    await _auth.ready;
    final fromConfig =
        systemInstruction != null && systemInstruction.trim().isNotEmpty;
    print('[GeminiService] generateReply start. historyIn=${history.length} '
        'images=${imagePaths.length} systemInstructionFromConfig=$fromConfig');

    final model = _buildModel(systemInstruction);

    final recentHistory = history.length > _historyLimit
        ? history.sublist(history.length - _historyLimit)
        : history;

    final geminiHistory = recentHistory.map(_toContent).toList();
    final chat = model.startChat(history: geminiHistory);

    final parts = <Part>[TextPart(prompt)];
    for (final path in imagePaths) {
      final bytes = await _readImage(path);
      if (bytes != null) {
        parts.add(InlineDataPart('image/jpeg', bytes));
      }
    }

    print('[GeminiService] sending to Gemini. parts=${parts.length}');
    try {
      final response = await chat.sendMessage(Content.multi(parts));
      final text = response.text ?? '';
      print('[GeminiService] reply received. length=${text.length}');
      return text;
    } catch (e, st) {
      print('[GeminiService] sendMessage FAILED: $e\n$st');
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
