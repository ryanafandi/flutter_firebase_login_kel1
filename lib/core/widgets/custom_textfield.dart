import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String label;

  final bool obscureText;

  final String? errorText;

  final Function(String)? onChanged;

  const CustomTextField({
    super.key,

    required this.controller,

    required this.label,

    this.obscureText = false,

    this.errorText,

    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      obscureText: obscureText,

      onChanged: onChanged,

      decoration: InputDecoration(labelText: label, errorText: errorText),
    );
  }
}
