import 'package:flutter/material.dart';
import '../theme/app_input_decoration.dart';

/// Campo de texto reutilizable. Con [readOnly] se ve gris, como en el diseño.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final String label;
  final TextEditingController? controller;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: appInputDecoration(label, filled: readOnly)
          .copyWith(suffixIcon: suffixIcon),
    );
  }
}