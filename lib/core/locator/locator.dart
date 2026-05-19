import 'package:get_it/get_it.dart';

import '../../data/repositories/cat_repository.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/storage/chat_firestore_storage.dart';
import '../../router/router.dart';
import '../services/auth/auth_service.dart';
import '../services/storage/chat_storage_service.dart';
import '../api/dio/base_dio.dart';
import '../api/service/api_service.dart';
import '../api/service/api_service_interface.dart';
import '../services/ai/gemini_service.dart';
import '../services/local_database/local_database_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalDatabaseService>(LocalDatabaseService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<AppRouter>(() => AppRouter(onRouteChanged: (uri) {}));
  locator.registerLazySingleton<BaseDio>(() => BaseDio());
  locator.registerLazySingleton<IApiService>(() => ApiService(baseDio: locator<BaseDio>()));
  locator.registerLazySingleton<ChatFirestoreStorage>(
    () => ChatFirestoreStorage(authService: locator<AuthService>()),
  );
  locator.registerLazySingleton<ChatStorageService>(
    () => ChatStorageService(authService: locator<AuthService>()),
  );
  locator.registerLazySingleton<GeminiService>(
    () => GeminiService(authService: locator<AuthService>()),
  );
  locator.registerLazySingleton<CatRepository>(() => CatRepository());
  locator.registerLazySingleton<ChatRepository>(
    () => ChatRepository(
      storage: locator<ChatFirestoreStorage>(),
      geminiService: locator<GeminiService>(),
      chatStorageService: locator<ChatStorageService>(),
      catRepository: locator<CatRepository>(),
    ),
  );
}
