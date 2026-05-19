import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_ai_project/data/models/tip.dart';

class TipFirestoreStorage {
  TipFirestoreStorage({FirebaseFirestore? firestore})
      : _db = firestore ??
            FirebaseFirestore.instanceFor(
              app: Firebase.app(),
              databaseId: _databaseId,
            );

  final FirebaseFirestore _db;
  static const String _databaseId = 'main-db';
  static const String _tag = '[TipFirestoreStorage]';

  Future<List<Tip>> loadTips() async {
    print('$_tag loadTips: querying tip collection ordered by documentId asc');
    try {
      final snap = await _db
          .collection('tip')
          .orderBy(FieldPath.documentId)
          .get();
      final tips = snap.docs.map(_tipFromDoc).where((t) => t.text.isNotEmpty).toList();
      print('$_tag loadTips: success. count=${tips.length}');
      return tips;
    } catch (e, st) {
      print('$_tag loadTips: FAILED. error=$e\n$st');
      rethrow;
    }
  }

  static Tip _tipFromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? const {};
    return Tip(
      id: doc.id,
      text: data['text'] as String? ?? '',
    );
  }
}
