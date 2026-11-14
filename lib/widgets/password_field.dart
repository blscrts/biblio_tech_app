import 'package:flutter/material.dart';
import 'app_text_field.dart';

/// Campo de contraseña con botón para mostrar u ocultar.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.label = 'Contraseña',
    this.controller,
    this.readOnly = false,
  });

  final String label;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      readOnly: widget.readOnly,
      obscureText: _hidden,
      suffixIcon: IconButton(
        icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _hidden = !_hidden),
      ),
    );
  }
}