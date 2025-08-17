import 'package:flutter/material.dart';

class OnboardingSkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingSkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: const Text("Skip", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
