import 'package:pet_ai_project/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../firebase_options.dart';
import '../app_config/env/evn_config.dart';
import '../locator/locator.dart';
import '../services/auth/auth_service.dart';
import '../services/local_database/local_database_service.dart';

abstract class InitializationService {
  static Future<void> preRunAppJobs() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    await EnvConfig.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    appRouter = AppRouter(onRouteChanged: (uri) {});
    await appRouter.initialize();
    setupLocator();
    await locator<LocalDatabaseService>().initialize();
    await locator<AuthService>().ensureSignedIn();
  }

  static Future<void> postRunAppJobs() async {
    // await locator.get<LocalDatabaseService>().initialize();
    // await locator.get<AppConfig>().initialize();
    // await PurchaseService.instance.initialize(
    //   revenueCatApiKeyIOS: 'appl_iUjIaKcXqanIWtFyiTfuLKKZaJg',
    //   revenueCatApiKeyAndroid: 'android-revenue-cat-key',
    //   installationId: locator.get<AppConfig>().installationId,
    //   enableLogs: true,
    //   isDebug: false,
    // );
  }
}
