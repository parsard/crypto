import 'package:flutter/material.dart';

class HelpTextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HelpTextLink({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.help_outline, size: 16, color: Colors.white.withOpacity(0.6)),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
