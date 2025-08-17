import 'package:crypto/view/apiKey/api_key_screen.dart';
import 'package:crypto/view/apiKey/logic/api_key_cubit.dart';
import 'package:crypto/view/market/market_screen.dart';
import 'package:crypto/view/onBoarding/logic/onboarding_cubit.dart';
import 'package:crypto/view/onBoarding/on_boarding_screen.dart';
import 'package:crypto/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        '/onboarding': (_) => BlocProvider(create: (_) => OnboardingCubit(), child: const OnboardingScreen()),
        '/api-key': (_) => BlocProvider(create: (_) => ApiKeyCubit(), child: const ApiKeyScreen()),
        '/market': (_) => const MarketScreen(),
      },
    );
  }
}
