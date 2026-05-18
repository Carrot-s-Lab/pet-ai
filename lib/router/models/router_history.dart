
class RouteHistory {
  final Uri route;

  late final String id;
  late final DateTime time;

  RouteHistory(this.route) {
    id = 'router_${route.path}';
    time = DateTime.now().toUtc();
  }

  @override
  String toString() {
    return 'route: $route, time: $time \n';
  }
}
