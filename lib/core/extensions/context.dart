import 'package:pet_ai_project/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext {
  /// Get the current locale of the app.
  Tr get tr => Tr.of(this);

  /// Get the current media query data of the app.
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
