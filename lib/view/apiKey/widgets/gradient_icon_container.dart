import 'package:flutter/material.dart';

class GradientIconContainer extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;

  const GradientIconContainer({
    super.key,
    required this.icon,
    this.colors = const [Color(0xFFFFD700), Color(0xFFFFA500)],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: colors.first.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)],
      ),
      child: Icon(icon, size: 50, color: Colors.white),
    );
  }
}
