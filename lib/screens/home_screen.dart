//Hairo Tarmeño Rojas

import 'package:flutter/material.dart';

import '../widgets/bibliogest_app_bar.dart';
import '../widgets/form_card.dart';
import '../widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  const Text(
                    '¡Bienvenido a BiblioGest!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Gestiona tu biblioteca de forma fácil y rápida.',
                    textAlign: TextAlign.center,
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
