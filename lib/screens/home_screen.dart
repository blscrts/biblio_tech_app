//Hairo Tarmeño Rojas

import 'package:flutter/material.dart';

import '../widgets/bibliogest_app_bar.dart';
import '../widgets/form_card.dart';
import '../widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _banner() => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.asset(
      'assets/images/biblioteca.jpg',
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 160,
        color: Colors.blue.shade50,
        child: const Icon(Icons.local_library, size: 72),
      ),
    ),
  );

  Widget _funcion(IconData icono, String texto) => Expanded(
    child: Column(
      children: [
        Icon(icono, size: 32),
        const SizedBox(height: 4),
        Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BiblioGestAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: FormCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _banner(),
                  const SizedBox(height: 16),
                  const Text(
                    '¡Bienvenido a BiblioGest!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'BiblioGest es una aplicación para gestionar tu biblioteca: '
                    'consulta el catálogo de libros, administra tu perfil y '
                    'accede a tu cuenta de forma fácil y rápida.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _funcion(Icons.menu_book, 'Catálogo'),
                      _funcion(Icons.person, 'Tu perfil'),
                      _funcion(Icons.lock_open, 'Acceso seguro'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Iniciar Sesión',
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: 'Catálogo de Libros',
                    onPressed: () => Navigator.pushNamed(context, '/catalogo'),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: 'Mi Perfil',
                    onPressed: () => Navigator.pushNamed(context, '/perfil'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
