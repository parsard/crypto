import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding_icon_glow.dart';
import 'onboarding_title.dart';
import 'onboarding_subtitle.dart';

class OnboardingPageContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color glowColor;

  const OnboardingPageContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80.h),
        OnboardingIconGlow(icon: icon, iconColor: iconColor, glowColor: glowColor),
        SizedBox(height: 60.h),
        OnboardingTitle(title: title),
        SizedBox(height: 24.h),
        OnboardingSubtitle(subtitle: subtitle),
        SizedBox(height: 100.h),
      ],
    );
  }
}
