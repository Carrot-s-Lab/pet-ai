import '../models/tip.dart';
import '../storage/tip_firestore_storage.dart';

class TipRepository {
  TipRepository({required TipFirestoreStorage storage}) : _storage = storage;

  final TipFirestoreStorage _storage;

  Future<List<Tip>> loadTips() => _storage.loadTips();
}
