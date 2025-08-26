import 'package:intl/intl.dart';

class Crypto {
  final String name;
  final String symbol;
  final double price;
  final String imageUrl;
  final double changePercent;
  final List<double> priceHistory;

  const Crypto({
    required this.name,
    required this.symbol,
    required this.price,
    required this.imageUrl,
    required this.changePercent,
    this.priceHistory = const [],
  });

  String get formattedPrice {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatter.format(price);
  }
}
