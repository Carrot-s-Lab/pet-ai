# Splash Screen Plan

Play `assets/videos/cattie_splash.mp4` on launch, then navigate to `/home`.

---

## Approach

Add a `/splash` route as the GoRouter `initialLocation`. The splash screen plays the video to completion (or a timeout fallback), then calls `context.go(RoutePaths.home)`. The video is never revisited — navigating back from home is not possible since GoRouter `go()` replaces the stack.

The native iOS/Android launch screen (the static frame shown before Flutter renders) is left as-is; this plan covers only the Flutter-layer splash.

---

## Dependencies

Add `video_player` to `pubspec.yaml`:

```yaml
video_player: ^2.11.1
```

Run `fvm flutter pub get` after adding.

---

## Files to create / modify

| File | Action |
|---|---|
| `pubspec.yaml` | Add `video_player: ^2.11.1` |
| `lib/router/route_paths.dart` | Add `static const String splash = '/splash';` |
| `lib/router/routes.dart` | Add a top-level `GoRoute` for `/splash` before the `StatefulShellRoute` |
| `lib/router/router.dart` | Change `initialLocation` from `RoutePaths.home` to `RoutePaths.splash`; update initial stack entry |
| `lib/layout/screens/splash/splash_screen.dart` | New file — video player widget |

---

## Implementation steps

### 1. Add route path

`lib/router/route_paths.dart`:
```dart
abstract class RoutePaths {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String account = '/account';
}
```

### 2. Register route

`lib/router/routes.dart` — prepend a top-level `GoRoute` to the `routes` list:
```dart
GoRoute(
  path: RoutePaths.splash,
  builder: (_, __) => const SplashScreen(),
),
// existing StatefulShellRoute ...
```

### 3. Update initial location

`lib/router/router.dart`:
- Change `initialLocation: RoutePaths.home` → `initialLocation: RoutePaths.splash`
- Change the initial stack push to `RouteHistory(Uri(path: RoutePaths.splash))`

### 4. Create SplashScreen widget

`lib/layout/screens/splash/splash_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../router/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _controller = VideoPlayerController.asset('assets/videos/cattie_splash.mp4')
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
        _controller.addListener(_onVideoProgress);
      });
  }

  void _onVideoProgress() {
    final duration = _controller.value.duration;
    if (duration > Duration.zero && _controller.value.position >= duration) {
      _navigateHome();
    }
  }

  void _navigateHome() {
    _controller.removeListener(_onVideoProgress);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    if (mounted) context.go(RoutePaths.home);
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoProgress);
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
```

Key design decisions:
- `FittedBox(fit: BoxFit.cover)` fills the screen regardless of video aspect ratio.
- `duration > Duration.zero` guard prevents a false positive when the player hasn't reported duration yet.
- The listener fires on every tick; removing it as the first thing in `_navigateHome` prevents double-navigation.
- `SystemUiMode.immersiveSticky` hides both status bar and nav bar for a cinematic feel; restored to `manual / top` when leaving (matching the app's existing SystemUiMode).
- If the video fails to initialize, the screen stays black — no fallback timeout.

---

## Redirect guard

The existing redirect in `router.dart` only catches `'/'` and sends to `/home`. No change needed — `/splash` is not `/`, so it passes through correctly.

After navigating to `/home` via `context.go()`, the splash route is replaced in the GoRouter stack so the user cannot go back to it.

---

## Testing checklist

- [ ] Video plays full-screen on device (iPhone + Android)
- [ ] App navigates to home automatically when video ends
- [ ] Back gesture/button from home does not return to splash
- [ ] Hot restart does not replay the splash (stateless restart goes to `/splash` again — acceptable; this is only a dev concern)
- [ ] No `video_player` resource leaks (dispose called on route pop)
