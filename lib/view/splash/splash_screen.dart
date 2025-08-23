import 'package:crypto_app/view/splash/widgets/animated_logo.dart';
import 'package:crypto_app/view/splash/widgets/animated_splash_loader.dart';
import 'package:crypto_app/view/splash/widgets/animated_title.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Start animations
    _startAnimations();

    // Navigate after delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  void _startAnimations() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Bitcoin Icon with Glow
                const AnimatedLogo(),

                SizedBox(height: 40.h),

                // Animated App Title
                const AnimatedTitle(),

                SizedBox(height: 60.h),

                // Loading Indicator
                const AnimatedSplashLoader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
