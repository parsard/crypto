import 'package:flutter/material.dart';

class OnboardingDoneButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingDoneButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.3), blurRadius: 15, spreadRadius: 1)],
        ),
        child: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
