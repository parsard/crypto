import 'package:crypto_app/view/onBoarding/logic/onboarding_cubit.dart';
import 'package:crypto_app/view/onBoarding/widgets/onboarding_done_button.dart';
import 'package:crypto_app/view/onBoarding/widgets/onboarding_next_button.dart';
import 'package:crypto_app/view/onBoarding/widgets/onboarding_page_content.dart';
import 'package:crypto_app/view/onBoarding/widgets/onboarding_skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: const OnboardingPageContent(
                title: "Welcome to Crypto Kade",
                subtitle: "Track and trade your favorite cryptocurrencies with ease and confidence",
                icon: Icons.currency_bitcoin,
                iconColor: Color(0xFFFFD700),
                glowColor: Color(0xFFFFD700),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: const OnboardingPageContent(
                title: "Real-time Data",
                subtitle: "Get the latest prices, charts, and market trends updated every second",
                icon: Icons.trending_up,
                iconColor: Color(0xFF00E676),
                glowColor: Color(0xFF00E676),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: const OnboardingPageContent(
                title: "Secure & Reliable",
                subtitle: "Your data is encrypted and protected with bank-level security protocols",
                icon: Icons.security,
                iconColor: Color(0xFFFF6B35),
                glowColor: Color(0xFFFF6B35),
              ),
            ),
          ],
          onDone: () => context.read<OnboardingCubit>().completeOnboarding(context),
          onSkip: () => context.read<OnboardingCubit>().skipOnboarding(context),
          showSkipButton: true,
          skip: OnboardingSkipButton(onTap: () => context.read<OnboardingCubit>().skipOnboarding(context)),
          next: const OnboardingNextButton(),
          done: OnboardingDoneButton(onTap: () => context.read<OnboardingCubit>().completeOnboarding(context)),
          dotsDecorator: DotsDecorator(
            size: Size(12.w, 12.h),
            activeSize: Size(24.w, 12.h),
            activeColor: const Color(0xFFFFD700),
            color: Colors.white.withOpacity(0.3),
            spacing: EdgeInsets.symmetric(horizontal: 4.w),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
          ),
          globalBackgroundColor: Colors.transparent,
          animationDuration: 300,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
