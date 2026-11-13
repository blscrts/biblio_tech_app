import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'widgets/app_text_field.dart';
import 'widgets/bibliogest_app_bar.dart';
import 'widgets/form_card.dart';
import 'widgets/password_field.dart';
import 'widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8D0C8),
      // Barra superior reutilizable con el logo "BiblioGest"
      appBar: const BiblioGestAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            // Tarjeta blanca reutilizable del grupo
            child: FormCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Color(0xFFE0ECFF),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 48,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ingresa tus credenciales de biblioteca',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  // Campo de texto reutilizable
                  AppTextField(
                    label: 'Correo institucional',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  // Campo de contraseña reutilizable con ojito
                  PasswordField(
                    label: 'Contraseña',
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 24),
                  // Botón principal azul reutilizable
                  PrimaryButton(
                    text: 'Ingresar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Bienvenido a BiblioGest: ${_emailController.text.isEmpty ? "Usuario" : _emailController.text}',
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: AppColors.primaryDark),
                    ),
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
