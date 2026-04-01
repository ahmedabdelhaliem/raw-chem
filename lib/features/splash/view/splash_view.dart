import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/app/app_prefs.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    final token = instance<AppPreferences>().getToken();
    if (token.isNotEmpty) {
      context.go(AppRouters.btmNav);
    } else {
      context.go(AppRouters.loginView);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.logo, width: 250, height: 250)
            .animate()
            // 1. Entrance: Blur to Clear + Scale + Slide Up
            .fadeIn(duration: 700.ms)
            .blur(begin: const Offset(10, 10), end: Offset.zero, duration: 800.ms)
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.0, 1.0),
              duration: 900.ms,
              curve: Curves.elasticOut,
            )
            .slideY(begin: 0.2, end: 0, duration: 800.ms, curve: Curves.easeOutQuad)
            // 2. Mid-Animation: Shimmer flare
            .then(delay: 200.ms)
            .shimmer(duration: 1200.ms, color: Colors.white.withOpacity(0.4))
            // 3. Looping: Subtle "Heartbeat" pulse to keep it alive
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.03, 1.03),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
