import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Estilo único para todos los campos de formulario de la app.
InputDecoration appInputDecoration(String label, {bool filled = false}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade500),
  );
  return InputDecoration(
    labelText: label,
    filled: filled,
    fillColor: AppColors.fieldFill,
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );
}