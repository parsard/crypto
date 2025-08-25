import 'package:flutter/material.dart';

class CryptoDetailHeader extends StatelessWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final String lastPrice;
  final String prevPrice;

  const CryptoDetailHeader({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.lastPrice,
    required this.prevPrice,
  });

  @override
  Widget build(BuildContext context) {
    Color priceColor = Colors.white;
    if (prevPrice.isNotEmpty && lastPrice.isNotEmpty) {
      final double newP = double.tryParse(lastPrice) ?? 0;
      final double oldP = double.tryParse(prevPrice) ?? 0;
      if (newP > oldP) {
        priceColor = Colors.greenAccent;
      } else if (newP < oldP) {
        priceColor = Colors.redAccent;
      }
    }
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 28,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            Text(symbol.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.7))),
          ],
        ),
        const Spacer(),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: Text(
              lastPrice,
              key: ValueKey(lastPrice),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: priceColor),
            )),
      ],
    );
  }
}
