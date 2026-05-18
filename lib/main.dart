import 'package:pet_ai_project/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/initialization/initialization_service.dart';
import 'core/utils/global.dart';
import 'generated/l10n.dart';
import 'layout/app/app_language.dart';
import 'layout/app/app_provider.dart';

late BuildContext appContext;

void main() async {
  await InitializationService.preRunAppJobs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppProviders(child: _MyApp());
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateScreenSize(data: MediaQuery.of(context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    updateScreenSize(data: MediaQuery.of(context));
    return Consumer<AppLanguageController>(
      builder: (context, controller, _) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: data.textScaler.clamp(
              minScaleFactor: 1,
              maxScaleFactor: 1,
            ),
          ),
          child: MaterialApp.router(
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(),
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: GoogleFonts.mulishTextTheme(),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              bottomAppBarTheme: const BottomAppBarThemeData(
                color: Colors.white,
              ),
            ),
            onGenerateTitle: (context) => 'PET AI',
            localizationsDelegates: [
              Tr.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: Tr.delegate.supportedLocales,
            locale: Locale.fromSubtags(
              languageCode: controller.currentLanguage.localeCode,
            ),
            routerConfig: appRouter.router,
            title: 'PET AI',
            // theme: AppTheme.of(context).themeData,
          ),
        );
      },
    );
  }
}
