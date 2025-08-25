import 'package:flutter/material.dart';

class OrderBookRow extends StatelessWidget {
  final String price;
  final String amount;
  final Color color;

  const OrderBookRow({
    super.key,
    required this.price,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(price, style: TextStyle(color: color, fontSize: 12)),
          Text(amount, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
