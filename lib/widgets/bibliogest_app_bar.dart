import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// AppBar con el logo y nombre de la app, para usar en cualquier pantalla.
class BiblioGestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BiblioGestAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      title: const Row(
        children: [
          Icon(Icons.menu_book_rounded, size: 30),
          SizedBox(width: 10),
          Text(
            'BiblioGest',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    );
  }
}