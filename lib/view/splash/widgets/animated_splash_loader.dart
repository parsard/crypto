import 'package:flutter/material.dart';

class AnimatedSplashLoader extends StatefulWidget {
  const AnimatedSplashLoader({Key? key}) : super(key: key);

  @override
  _AnimatedSplashLoaderState createState() => _AnimatedSplashLoaderState();
}

class _AnimatedSplashLoaderState extends State<AnimatedSplashLoader>
    with TickerProviderStateMixin {
  late AnimationController _textController;

  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Text animations
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _textOpacityAnimation,
          child: Column(
            children: [
              // Custom Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFFFFD700).withOpacity(0.8),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
