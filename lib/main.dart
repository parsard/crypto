import 'package:crypto/services/nobitex_service.dart';
import 'package:crypto/view/apiKey/api_key_screen.dart';
import 'package:crypto/view/apiKey/logic/api_key_cubit.dart';
import 'package:crypto/view/market/logic/market_cubit.dart';
import 'package:crypto/view/market/market_screen.dart';

import 'package:crypto/view/onBoarding/logic/onboarding_cubit.dart';
import 'package:crypto/view/onBoarding/on_boarding_screen.dart';
import 'package:crypto/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatefulWidget {
  const CryptoApp({super.key});

  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  final _storage = const FlutterSecureStorage();
  String? _savedToken;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storage.read(key: 'api_token');
    setState(() {
      _savedToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nobitexService = NobitexService();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crypto',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreen(),
          routes: {
            '/onboarding': (_) => BlocProvider(create: (_) => OnboardingCubit(), child: const OnboardingScreen()),
            '/api-key': (_) => BlocProvider(create: (_) => ApiKeyCubit(nobitexService), child: const ApiKeyScreen()),
            '/market': (_) {
              if (_savedToken == null) {
                // token missing — redirect to api-key screen
                return BlocProvider(create: (_) => ApiKeyCubit(nobitexService), child: const ApiKeyScreen());
              }
              return BlocProvider(
                create: (_) => MarketCubit(service: nobitexService, token: _savedToken!)..fetchMarketStats(),
                child: const MarketScreen(),
              );
            },
          },
        );
      },
    );
  }
}
