import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradientAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const CustomGradientAppBar({super.key, required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.w),
            ),
            child: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white), onPressed: onBack),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}
