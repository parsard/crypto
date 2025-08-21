import 'package:crypto/view/market/widgets/crypto_card.dart';
import 'package:crypto/view/market/widgets/crypto_suggestion.dart';
import 'package:crypto/view/market/widgets/market_search_bar.dart';
import 'package:crypto/view/market/widgets/section_title.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final List<Map<String, String>> _cryptos = [
    {
      'name': 'Bitcoin',
      'symbol': 'BTC',
      'price': '\$65,432',
      'imageUrl': 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=032',
    },
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'price': '\$3,210',
      'imageUrl': 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=032',
    },
    {
      'name': 'Tether',
      'symbol': 'USDT',
      'price': '\$1.00',
      'imageUrl': 'https://cryptologos.cc/logos/tether-usdt-logo.png?v=032',
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final suggestions =
        _cryptos
            .where(
              (c) =>
                  c['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  c['symbol']!.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Top Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Market",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            /// --- Search Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MarketSearchBar(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            /// --- Suggestions ---
            if (_searchQuery.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFF1A1A27)),
                child: Column(
                  children:
                      suggestions.isNotEmpty
                          ? suggestions
                              .map(
                                (c) => CryptoSuggestion(
                                  name: c['name']!,
                                  symbol: c['symbol']!,
                                  onTap: () {
                                    // You can set searchQuery to the tapped item name or open details
                                    setState(() {
                                      _searchQuery = c['name']!;
                                    });
                                  },
                                ),
                              )
                              .toList()
                          : [
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('No matches found', style: TextStyle(color: Colors.white54)),
                            ),
                          ],
                ),
              ),

            const SizedBox(height: 16),

            /// --- Crypto Row ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(title: "Top Cryptos", onSeeAll: () {}),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children:
                    _cryptos
                        .map(
                          (c) => CryptoCard(
                            name: c['name']!,
                            symbol: c['symbol']!,
                            price: c['price']!,
                            imageUrl: c['imageUrl']!,
                            onTap: () {},
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
