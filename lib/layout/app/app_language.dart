import '../../core/api/dio/base_dio.dart';
import '../../core/locale/locale_model.dart';
import '../../core/locator/locator.dart';
import '../../core/services/local_database/local_database_service.dart';
import '../common/change_notifier/safe_change_notifier.dart';

class AppLanguageController extends SafeChangeNotifier {

  final localDatabaseService = locator<LocalDatabaseService>();
  LocaleModel currentLanguage = LocaleModel.en;

  void initialize() {
    final localeCode = localDatabaseService.getLocaleCode();
    final model = LocaleModel.all.firstWhere((element) => element.localeCode == localeCode, orElse: () => LocaleModel.en);
    locator<BaseDio>().cultureCode = model.languageCode;
    currentLanguage = model;
  }

  void setLocale(LocaleModel model) {
    locator<BaseDio>().cultureCode = model.languageCode;
    currentLanguage = model;
    localDatabaseService.saveLocale(currentLanguage.localeCode);
    notifyListeners();
  }
}
