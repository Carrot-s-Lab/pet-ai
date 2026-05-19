// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get emptyField => '@field@ is empty';

  @override
  String get information => 'Information';

  @override
  String get emptyInformation => 'Information is empty';

  @override
  String get allFieldsAreRequired => 'All fields are required';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get home => 'Home';

  @override
  String get account => 'Account';

  @override
  String get chatDisclaimer =>
      'General wellness information - not veterinary advice.';
}
