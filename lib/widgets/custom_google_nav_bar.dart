// lib/view/widgets/custom_google_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomGoogleNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomGoogleNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1.5),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A27),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.cyanAccent,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 500),
            tabBackgroundColor: Colors.cyan.withOpacity(0.2),
            color: Colors.grey[400],
            tabs: const [
              GButton(
                icon: Icons.candlestick_chart_outlined,
                text: 'Market',
              ),
              GButton(
                icon: Icons.account_balance_wallet_outlined,
                text: 'Wallets',
              ),
              // GButton(
              //   icon: Icons.swap_horiz_rounded,
              //   text: 'Trade',
              // ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
