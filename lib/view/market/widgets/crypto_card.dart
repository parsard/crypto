import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 24),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(symbol.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
            const SizedBox(height: 6),
            Text(price, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
