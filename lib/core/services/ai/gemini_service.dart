import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';

import '../../../data/models/chat_message.dart';

class GeminiService {
  static const _modelName = 'gemini-2.5-flash';
  static const _systemInstruction =
      'You are a pet health consultant. Reply in English using clear markdown format '
      '(headings, bullets, bold when appropriate). '
      'For serious or persistent symptoms, always recommend the user take their pet to a veterinarian. '
      'Do not provide final medical diagnoses in place of a specialist.';

  static const int _historyLimit = 20;

  late final GenerativeModel _model;

  GeminiService() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: _modelName,
      systemInstruction: Content.system(_systemInstruction),
    );
  }

  Future<String> generateReply({
    required List<ChatMessage> history,
    required String prompt,
    List<String> imagePaths = const [],
  }) async {
    print('[GeminiService] generateReply start. historyIn=${history.length} images=${imagePaths.length}');

    final recentHistory = history.length > _historyLimit
        ? history.sublist(history.length - _historyLimit)
        : history;
    print('[GeminiService] using historySlice=${recentHistory.length} (limit=$_historyLimit)');

    final geminiHistory = recentHistory.map(_toContent).toList();
    final chat = _model.startChat(history: geminiHistory);
    print('[GeminiService] chat session started');

    final parts = <Part>[TextPart(prompt)];
    for (final path in imagePaths) {
      print('[GeminiService] reading image: $path');
      final bytes = await _readImage(path);
      if (bytes != null) {
        parts.add(InlineDataPart('image/jpeg', bytes));
        print('[GeminiService] image loaded: ${bytes.length} bytes');
      } else {
        print('[GeminiService] image not found or unreadable: $path');
      }
    }

    print('[GeminiService] sending message to Gemini. parts=${parts.length}');
    try {
      final response = await chat.sendMessage(Content.multi(parts));
      final text = response.text ?? '';
      print('[GeminiService] response received. length=${text.length}');
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
