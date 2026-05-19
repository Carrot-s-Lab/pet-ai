import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_ai_project/router/models/route_transition.dart';
import 'package:pet_ai_project/router/transition/shell_route_animation.dart';
import 'package:provider/provider.dart';
import '../layout/screens/chat/controller/chat_controller.dart';
import '../layout/screens/chat/ui/chat_screen.dart';
import '../layout/screens/onboarding/controller/onboarding_controller.dart';
import '../layout/screens/onboarding/ui/onboarding_screen.dart';
import '../layout/screens/session_list/controller/session_list_controller.dart';
import '../layout/screens/session_list/ui/session_list_screen.dart';
import '../layout/common/main_scaffold/main_scaffold.dart';
import '../layout/screens/account/account_screen.dart';
import '../layout/screens/home/home_screen.dart';
import '../layout/screens/splash/splash_screen.dart';
import 'route_paths.dart';

abstract class AppRouterRoutes {
  static String get newScreenKey {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    log('newScreenKey: $key');
    return key;
  }

  static List<RouteBase> routes = [
    GoRoute(path: RoutePaths.splash, builder: (_, _) => const SplashScreen()),
    GoRoute(
      path: RoutePaths.onboarding,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: ChangeNotifierProvider(create: (_) => OnboardingController(), child: const OnboardingScreen()),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      // builder: (_, _) => ChangeNotifierProvider(create: (_) => OnboardingController(), child: const OnboardingScreen()),
    ),
    AnimatedStatefulShellRoute(
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: ShellRouteTransitions.fade,
      pageBuilder: (context, state, navigationShell) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: MainScaffold(navigationShell: navigationShell),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      // pageBuilder: (context, state, navigationShell) {
      //   return MaterialPage(child: MainScaffold(navigationShell: navigationShell));
      // },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.home,
              builder: (_, state) {
                final keyId = GlobalKey(debugLabel: state.uri.queryParameters['stateId']);
                return HomeScreen(key: keyId);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.sessions,
              builder: (_, _) => ChangeNotifierProvider(create: (_) => SessionListController(), child: const SessionListScreen()),
            ),
          ],
        ),
        StatefulShellBranch(routes: [GoRoute(path: RoutePaths.account, builder: (_, _) => const AccountScreen())]),
      ],
    ),
    GoRoute(
      path: RoutePaths.chat,
      builder: (_, state) {
        final sessionId = state.uri.queryParameters['sessionId'] ?? '';
        return ChangeNotifierProvider(create: (_) => ChatController(sessionId: sessionId), child: ChatScreen(sessionId: sessionId));
      },
    ),
  ];
}
