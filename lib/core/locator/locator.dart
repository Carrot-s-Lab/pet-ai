import 'package:get_it/get_it.dart';

import '../../router/router.dart';
import '../api/dio/base_dio.dart';
import '../api/service/api_service.dart';
import '../api/service/api_service_interface.dart';
import '../services/local_database/local_database_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalDatabaseService>(LocalDatabaseService());
  locator.registerLazySingleton<AppRouter>(() => AppRouter(onRouteChanged: (uri) {}));
  locator.registerLazySingleton<BaseDio>(() => BaseDio());
  locator.registerLazySingleton<IApiService>(() => ApiService(baseDio: locator<BaseDio>()));
}
