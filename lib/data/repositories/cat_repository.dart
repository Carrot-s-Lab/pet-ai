import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/core/services/local_database/local_database_service.dart';

import '../models/cat.dart';

class CatRepository {
  CatRepository({LocalDatabaseService? localDb})
      : _localDb = localDb ?? locator<LocalDatabaseService>();

  final LocalDatabaseService _localDb;

  Future<Cat?> getCurrentCat() async {
    return _localDb.getCatProfile();
  }
}
