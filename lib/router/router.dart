
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'models/router_history.dart';
import 'routes.dart';
import 'route_paths.dart';

late AppRouter appRouter;

class AppRouter {
  final void Function(Uri) onRouteChanged;

  AppRouter({
    required this.onRouteChanged,
  });

  late final GoRouter router;
  final List<RouteHistory> stack = [];

  Uri get currentRoute => router.routeInformationProvider.value.uri;

  Uri get previousToCurrentRoute => _getPreviousToRouteById(stack.last.id);

  Future<void> initialize() async {
    router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
      initialLocation: RoutePaths.home,
      redirect: (context, state) {
        if (state.fullPath == '/') {
          return RoutePaths.home;
        }
        return null;
      },
      routes: AppRouterRoutes.routes,
    );

    stack.add(RouteHistory(Uri(path: RoutePaths.home)));
  }

  void go(BuildContext context, String route, {Map<String, String>? params, Object? extra}) {
    final Uri uri = Uri(path: route, queryParameters: params);

    if (stack.isNotEmpty) {
      stack.removeLast();
    }

    stack.add(RouteHistory(uri));

    onRouteChanged.call(uri);
    context.go(uri.toString(), extra: extra);
  }

  void pushReplacement(BuildContext context, String route, {Map<String, String>? params, Object? extra}) {
    final Uri uri = Uri(path: route, queryParameters: params);

    if (stack.isNotEmpty) {
      stack.removeLast();
    }

    stack.add(RouteHistory(uri));

    onRouteChanged.call(uri);

    context.pushReplacement(uri.toString(), extra: extra);
  }

  void goBack(BuildContext context) {
    context.go(previousToCurrentRoute.toString());

    onRouteChanged.call(previousToCurrentRoute);

    stack.removeLast();
  }

  Future<Object?> push(BuildContext context, String route, {Map<String, String>? params = const {}, Object? extra}) async {
    final Uri uri = Uri(path: route, queryParameters: params);

    stack.add(RouteHistory(uri));

    onRouteChanged.call(uri);

    return await context.push(uri.toString(), extra: extra);
  }

  void pop(BuildContext context, {dynamic value}) {

    context.pop(value);

    onRouteChanged.call(previousToCurrentRoute);

    stack.removeLast();
  }

  Uri _getPreviousToRouteById(String id) {
    final index = stack.indexWhere((element) => element.id == id);

    if (index == 0) {
      return Uri(path: '/');
    }

    return stack[index - 1].route;
  }
}
