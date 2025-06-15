import 'package:crypto/view/apiKey/api_key_screen.dart';
import 'package:crypto/view/market/market_screen.dart';
import 'package:crypto/view/onBoarding/on_boarding_screen.dart';
import 'package:crypto/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Bazar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      routes: {
        '/api-key': (context) => const ApiKeyScreen(),
        '/market': (context) => const MarketScreen(),
      },
    );
  }
}
