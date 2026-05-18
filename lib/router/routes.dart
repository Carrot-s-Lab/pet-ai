import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../layout/common/main_scaffold/main_scaffold.dart';
import '../layout/screens/account/account_screen.dart';
import '../layout/screens/home/home_screen.dart';
import 'route_paths.dart';

abstract class AppRouterRoutes {
  static String get newScreenKey {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    log('newScreenKey: $key');
    return key;
  }

  static List<RouteBase> routes = [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return MaterialPage(child: MainScaffold(navigationShell: navigationShell));
      },
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
              path: RoutePaths.account,
              builder: (_, state) => const AccountScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}
