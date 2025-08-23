import 'package:crypto_app/services/auth_cubit.dart';
import 'package:crypto_app/services/profile_service.dart';
import 'package:crypto_app/view/profile/widget/profile_widgets.dart';
import 'package:flutter/material.dart'; // import اصلی برای ویجت‌ها
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/profile_cubit.dart';
import 'logic/profile_state.dart';

// ویجت Wrapper برای بررسی وضعیت احراز هویت
class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // مشاهده وضعیت احراز هویت از AuthCubit
    final authState = context.watch<AuthCubit>().state;

    // اگر کاربر احراز هویت نشده باشد، یک پیام خطا نمایش داده می‌شود
    if (!authState.isAuthenticated || authState.token == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F0F1E),
        appBar: AppBar(
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1A1A27),
        ),
        body: const Center(
          child: Text(
            'Authentication Error: Please log in.',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        ),
      );
    }

    // اگر کاربر احراز هویت شده باشد، ProfileCubit را ایجاد کرده و صفحه پروفایل را نمایش می‌دهد
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileService: ProfileService(),
        token: authState.token!,
      )..fetchProfile(), // فراخوانی اولیه برای دریافت اطلاعات پروفایل
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
      context.read<AuthCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A1A27),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.initial:
            case ProfileStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProfileStatus.failure:
              return Center(
                child: Text(
                  state.error ?? 'An unknown error occurred.',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            case ProfileStatus.success:
              final user = state.userProfile;
              if (user == null) {
                return const Center(
                  child: Text(
                    'Profile data is empty.',
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                ),
              );
          }
        },
      ),
    );
  }
}
