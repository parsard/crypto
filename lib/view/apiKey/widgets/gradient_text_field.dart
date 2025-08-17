import 'package:flutter/material.dart';

class GradientTextField extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? errorText;
  final bool isObscured;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;

  const GradientTextField({
    super.key,
    required this.label,
    this.value,
    this.hint,
    this.errorText,
    required this.isObscured,
    required this.onChanged,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]),
        border: Border.all(
          color: errorText != null ? Colors.red.withOpacity(0.5) : Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        obscureText: isObscured,
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          prefixIcon: Icon(Icons.vpn_key_rounded, color: Colors.white.withOpacity(0.7)),
          suffixIcon: IconButton(
            icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.white.withOpacity(0.7)),
            onPressed: onToggleVisibility,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }
}
