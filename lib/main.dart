import 'package:crypto_app/main_screen.dart';
import 'package:crypto_app/services/auth_cubit.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/view/apiKey/api_key_screen.dart';
import 'package:crypto_app/view/apiKey/logic/api_key_cubit.dart';
import 'package:crypto_app/view/market/logic/market_cubit.dart';
import 'package:crypto_app/view/market/logic/market_state.dart';
import 'package:crypto_app/view/onBoarding/logic/onboarding_cubit.dart';
import 'package:crypto_app/view/onBoarding/on_boarding_screen.dart';
import 'package:crypto_app/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:crypto_app/core/animations.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(nobitexService: NobitexService())..checkAuth(),
      child: const CryptoApp(),
    ),
  );
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

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
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: const Color(0xFF0F0F1E),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              })),
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Scaffold(
                  body: Center(
                    child: Lottie.asset(
                      JsonAssets.splashCrypto,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }

              // Authenticated → Market
              if (state.isAuthenticated && state.token != null) {
                return BlocProvider(
                  create: (_) => MarketCubit(
                    service: nobitexService,
                    token: state.token!,
                  )..fetchMarketStats(),
                  child: BlocBuilder<MarketCubit, MarketState>(
                    builder: (context, marketState) {
                      if (marketState.isLoading) {
                        return Scaffold(
                          body: Center(
                            child: Lottie.asset(
                              JsonAssets.splashCrypto,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }
                      return const MainScreen();
                    },
                  ),
                );
              }
              return const SplashScreen();
            },
          ),
          routes: {
            '/onboarding': (_) => BlocProvider(
                  create: (_) => OnboardingCubit(),
                  child: const OnboardingScreen(),
                ),
            '/api-key': (_) => BlocProvider(
                  create: (_) => ApiKeyCubit(nobitexService),
                  child: const ApiKeyScreen(),
                ),
          },
        );
      },
    );
  }
}
