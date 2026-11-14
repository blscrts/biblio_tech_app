import 'package:flutter/material.dart';
import '../theme/app_input_decoration.dart';

/// Lista desplegable reutilizable para cualquier tipo de dato
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.itemLabel,
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  /// Cómo mostrar cada opción (por defecto usa toString()).
  final String Function(T)? itemLabel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      decoration: appInputDecoration(label),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel?.call(item) ?? item.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}