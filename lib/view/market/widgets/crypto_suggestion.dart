import 'package:flutter/material.dart';

class CryptoSuggestion extends StatelessWidget {
  final String name;
  final String symbol;
  final VoidCallback onTap;

  const CryptoSuggestion({super.key, required this.name, required this.symbol, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: const Color(0xFF1E1E2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(name, style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(symbol.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
      onTap: onTap,
    );
  }
}
