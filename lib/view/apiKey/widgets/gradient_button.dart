import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final List<Color>? colors;

  const GradientButton({super.key, required this.label, this.isLoading = false, this.onPressed, this.colors});

  @override
  Widget build(BuildContext context) {
    final gradientColors = colors ?? [const Color(0xFFFFD700), const Color(0xFFFFA500)];

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // ensures no white fill appears behind gradient
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent, // removes shadow overlay
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child:
              isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
