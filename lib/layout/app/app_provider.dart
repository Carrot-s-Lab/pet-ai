import 'package:pet_ai_project/layout/app/app_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/home/controller/home_controller.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController(), lazy: true),
        ChangeNotifierProvider(
          create: (_) => AppLanguageController(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
