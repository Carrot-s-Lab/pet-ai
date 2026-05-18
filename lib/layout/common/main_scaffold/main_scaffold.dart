import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/main_bottom_navigation_bar.dart';

late BuildContext mainScaffoldContext;

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    mainScaffoldContext = context;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: navigationShell,
      bottomNavigationBar: MainBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
      ),
    );
  }
}
