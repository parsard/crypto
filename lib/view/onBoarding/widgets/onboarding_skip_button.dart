import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingSkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.w),
        ),
        child: Text("Skip", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
