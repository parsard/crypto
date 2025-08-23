import 'package:crypto_app/view/market/market_screen.dart';
import 'package:crypto_app/view/profile/profile_screen.dart';
import 'package:crypto_app/widgets/custom_google_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MarketScreen(),
    PlaceholderScreen(screenName: "Wallets"),
    PlaceholderScreen(screenName: "Trade"), // Placeholder
    ProfileScreenWrapper(), // Using the wrapper is correct here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: CustomGoogleNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String screenName;
  const PlaceholderScreen({super.key, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Center(
        child: Text(
          screenName,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
