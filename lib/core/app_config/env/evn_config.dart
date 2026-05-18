import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constant.dart';

class EnvConfig {
  const EnvConfig._();

  static late final Map<String, String> environment;

  static String baseUrl() {
    final key = environment[EnvConstants.baseUrl] ?? '';
    return key;
  }

  static String code() {
    final key = environment[EnvConstants.code] ?? '';
    return key;
  }

  static Future<void> init() async {
    await dotenv.load(fileName: EnvConstants.envFile);
    environment = dotenv.env;
  }
}
