import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../auth/auth_service.dart';

class ChatStorageService {
  ChatStorageService({
    required AuthService authService,
    FirebaseStorage? storage,
    Uuid? uuid,
  })  : _auth = authService,
        _storage = storage ?? FirebaseStorage.instance,
        _uuid = uuid ?? const Uuid();

  final AuthService _auth;
  final FirebaseStorage _storage;
  final Uuid _uuid;

  static const String _tag = '[ChatStorage]';

  /// Uploads [imageBytes] (in order) under chat_images/{sessionId}/ and returns
  /// the download URLs in the same order. Uploads run in parallel.
  Future<List<String>> uploadImages({
    required String sessionId,
    required List<Uint8List> imageBytes,
  }) async {
    await _auth.ready;
    if (imageBytes.isEmpty) {
      print('$_tag uploadImages: skip. no images to upload');
      return const [];
    }

    final totalBytes = imageBytes.fold<int>(0, (sum, b) => sum + b.length);
    print('$_tag uploadImages: starting. sessionId=$sessionId '
        'count=${imageBytes.length} totalBytes=$totalBytes');

    try {
      final futures = imageBytes
          .asMap()
          .entries
          .map((entry) => _uploadSingle(sessionId, entry.key, entry.value));
      final urls = await Future.wait(futures);
      print('$_tag uploadImages: success. sessionId=$sessionId count=${urls.length}');
      return urls;
    } catch (e, st) {
      print('$_tag uploadImages: FAILED. sessionId=$sessionId error=$e\n$st');
      rethrow;
    }
  }

  Future<String> _uploadSingle(
    String sessionId,
    int index,
    Uint8List bytes,
  ) async {
    final fileName = '${_uuid.v4()}.jpg';
    final path = 'chat_images/$sessionId/$fileName';
    print('$_tag _uploadSingle: index=$index path=$path bytes=${bytes.length}');

    try {
      final ref = _storage.ref().child(path);
      final task = await ref.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await task.ref.getDownloadURL();
      print('$_tag _uploadSingle: success. index=$index path=$path url=$url');
      return url;
    } catch (e, st) {
      print('$_tag _uploadSingle: FAILED. index=$index path=$path error=$e\n$st');
      rethrow;
    }
  }
}
