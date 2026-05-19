import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../color/app_color.dart';
import 'widgets/main_bottom_navigation_bar.dart';

late BuildContext mainScaffoldContext;

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.navigationShell});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    mainScaffoldContext = context;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          navigationShell,
          // Softens the hard BackdropFilter clip edge at the top of the glass
          // pill — content fades into the bar the same way iOS does natively.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 110,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.appBackground.withValues(alpha: 0), AppColors.appBackground.withValues(alpha: 0.72)],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(currentIndex: navigationShell.currentIndex),
    );
  }
}
