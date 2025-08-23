import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          // The page we are navigating to
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,

          // The transition animation
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation, // Use the animation value to control opacity
            child: child,
          ),

          // Set the transition duration
          transitionDuration: const Duration(milliseconds: 300),
          // Optional: Set reverse transition duration
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
}
