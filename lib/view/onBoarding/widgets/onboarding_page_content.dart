import 'package:flutter/material.dart';
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
        const SizedBox(height: 80),
        OnboardingIconGlow(icon: icon, iconColor: iconColor, glowColor: glowColor),
        const SizedBox(height: 60),
        OnboardingTitle(title: title),
        const SizedBox(height: 24),
        OnboardingSubtitle(subtitle: subtitle),
        const SizedBox(height: 100),
      ],
    );
  }
}
