import 'package:crypto_app/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widget for the header section with name and email
class ProfileHeader extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileHeader({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45.r,
          backgroundColor: Colors.blueAccent,
          child: Text(
            userProfile.firstName.isNotEmpty ? userProfile.firstName[0] : 'U',
            style: TextStyle(fontSize: 40.sp, color: Colors.white),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          userProfile.fullName,
          style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          userProfile.email,
          style: TextStyle(color: Colors.white70, fontSize: 16.sp),
        ),
      ],
    );
  }
}

// A reusable row for displaying info like "Title: Value"
class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white54, fontSize: 15.sp)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
        ],
      ),
    );
  }
}

// A card widget to display bank card information
class BankCardWidget extends StatelessWidget {
  final BankCard card;
  const BankCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A27),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.bank,
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            card.number,
            style: TextStyle(color: Colors.white70, fontSize: 18.sp, letterSpacing: 1.5),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.owner,
                style: TextStyle(color: Colors.white54, fontSize: 14.sp),
              ),
              if (card.confirmed) const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoutConfirmationSheet extends StatelessWidget {
  const LogoutConfirmationSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A27),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Confirm Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h), // فاصله امن برای پایین صفحه
        ],
      ),
    );
  }
}

class LogoutSection extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const LogoutSection({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onLogoutPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A27),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.redAccent, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A simple section title
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
