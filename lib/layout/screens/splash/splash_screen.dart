import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:video_player/video_player.dart';
import '../../../router/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;
  bool _ctaVisible = false;

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
    if (_ctaVisible) return;
    final duration = _controller.value.duration;
    if (duration > Duration.zero && _controller.value.position >= duration) {
      _controller.removeListener(_onVideoProgress);
      if (mounted) setState(() => _ctaVisible = true);
    }
  }

  void _goToOnboarding() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    if (mounted) context.go(RoutePaths.onboarding);
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
      body: Stack(
        children: [
          // Video fills the screen
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

          // CTA fades in after video finishes
          AnimatedOpacity(
            opacity: _ctaVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  MediaQuery.of(context).padding.bottom + 48,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your cat\'s AI care companion',
                      style: AppFonts.captionM.apply(color: AppColors.appWhite.withValues(alpha: 0.6)),
                    ),
                    const Gap(16),
                    _SplashButton(onTap: _goToOnboarding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashButton extends StatelessWidget {
  const _SplashButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.caramel, AppColors.caramelDeep],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.caramel.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text('Get started', style: AppFonts.ctaPrimary.apply(color: AppColors.appWhite)),
        ),
      ),
    );
  }
}
