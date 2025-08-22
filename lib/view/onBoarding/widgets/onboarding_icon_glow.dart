import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingIconGlow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color glowColor;

  const OnboardingIconGlow({super.key, required this.icon, required this.iconColor, required this.glowColor});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, _) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Container(
            width: 140.w,
            height: 140.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [iconColor, iconColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(35.r),
              boxShadow: [
                BoxShadow(color: glowColor.withOpacity(0.4 * value), blurRadius: 30 * value, spreadRadius: 5 * value),
              ],
            ),
            child: Icon(icon, size: 70, color: Colors.white),
          ),
        );
      },
    );
  }
}
