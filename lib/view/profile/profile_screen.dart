// lib/view/profile/profile_screen.dart

import 'package:crypto_app/core/animations.dart';
import 'package:crypto_app/services/auth_cubit.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/services/profile_service.dart';
import 'package:crypto_app/services/tab_cubit.dart';
import 'package:crypto_app/view/profile/widget/profile_widgets.dart';
import 'package:crypto_app/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'logic/profile_cubit.dart';
import 'logic/profile_state.dart';

final GlobalKey<NavigatorState> profileTabNavKey = GlobalKey<NavigatorState>();

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    if (!authState.isAuthenticated || authState.token == null) {
      return SplashScreen();
    }
    final nobitexService = context.read<NobitexService>();

    return BlocProvider(
      create: (context) => ProfileCubit(
        profileService: ProfileService(nobitexService),
        token: authState.token!,
      )..fetchProfile(),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutConfirmationSheet(BuildContext context) async {
  final bool? shouldLogout = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext sheetContext) {
      return LogoutConfirmationSheet();
    },
  );

  if (shouldLogout == true && context.mounted) {
    await context.read<AuthCubit>().logout();

    Navigator.of(context).pushNamedAndRemoveUntil(
      '/splash', 
      (Route<dynamic> route) => false,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- New Header (Styled like MarketScreen) ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                      onPressed: () => context.read<TabCubit>().changeTab(0),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              /// --- Profile Content Area ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ProfileStatus.initial:
                      case ProfileStatus.loading:
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
                      case ProfileStatus.failure:
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text(
                              state.error ?? 'An unknown error occurred.',
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        );
                      case ProfileStatus.success:
                        final user = state.userProfile;
                        if (user == null) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Text(
                                'Profile data is empty.',
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Center(child: ProfileHeader(userProfile: user)),
                            SizedBox(height: 30.h),
                            const SectionTitle(title: 'Personal Information'),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A27),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  InfoRow(title: 'Mobile Number', value: user.mobile),
                                  const Divider(color: Colors.white10, height: 1),
                                  InfoRow(title: 'National Code', value: user.nationalCode),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            const SectionTitle(title: 'Bank Cards'),
                            if (user.bankCards.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    'No bank cards found.',
                                    style: TextStyle(color: Colors.white54, fontSize: 14.sp),
                                  ),
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A1A27),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  children: List.generate(user.bankCards.length, (index) {
                                    final card = user.bankCards[index];
                                    return Column(
                                      children: [
                                        BankCardWidget(card: card),
                                        if (index < user.bankCards.length - 1)
                                          const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            SizedBox(height: 32.h),
                            LogoutSection(
                              onLogoutPressed: () {
                                _showLogoutConfirmationSheet(context);
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
