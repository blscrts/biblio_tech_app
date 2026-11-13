import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Foto circular de usuario con el botón "Cambiar foto de usuario".
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({super.key, required this.onChangePhoto, this.image});

  final VoidCallback onChangePhoto;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryDark, width: 3),
          ),
          child: CircleAvatar(
            radius: 64,
            backgroundColor: const Color(0xFFD3E1EE),
            backgroundImage: image,
            child: image == null
                ? const Icon(Icons.person,
                    size: 100, color: AppColors.primaryDark)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: onChangePhoto,
          icon: const Icon(Icons.photo_camera, color: AppColors.primaryDark),
          label: const Text(
            'Cambiar foto de usuario',
            style: TextStyle(color: AppColors.primaryDark, fontSize: 16),
          ),
        ),
      ],
    );
  }
}