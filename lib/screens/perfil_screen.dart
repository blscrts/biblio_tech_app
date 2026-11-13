import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_dropdown_field.dart';
import '../widgets/app_text_field.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/bibliogest_app_bar.dart';
import '../widgets/form_card.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_button.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // Cambia estas opciones por las de tu proyecto
  static const _instituciones = [
    'Biblioteca municipal',
    'Biblioteca escolar',
    'Biblioteca universitaria',
    'Centro comunitario',
    'Biblioteca parroquial',
    'Otro',
  ];

  final _nombresCtrl = TextEditingController(text: 'Nombres');
  final _apellidosCtrl = TextEditingController(text: 'Apellidos');
  final _passwordCtrl = TextEditingController(text: '12345678');
  String? _institucion;

  @override
  void dispose() {
    _nombresCtrl.dispose();
    _apellidosCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  void _guardar() {
    // TODO: guardar los datos (Firebase, API, etc.)
    _mostrarMensaje(_institucion == null
        ? 'Selecciona tu institución o espacio comunitario'
        : 'Cambios guardados');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: const BiblioGestAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FormCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AvatarPicker(
                    // TODO: integrar image_picker
                    onChangePhoto: () => _mostrarMensaje('Próximamente'),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: 'Nombres',
                    controller: _nombresCtrl,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Apellidos',
                    controller: _apellidosCtrl,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  AppDropdownField<String>(
                    label: 'Institución o Espacio Comunitario',
                    items: _instituciones,
                    value: _institucion,
                    onChanged: (v) => setState(() => _institucion = v),
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    label: 'Seguridad y Contraseña',
                    controller: _passwordCtrl,
                    readOnly: true,
                  ),
                  TextButton(
                    // TODO: navegar a la pantalla de cambio de contraseña
                    onPressed: () {},
                    child: const Text(
                      'Cambiar contraseña',
                      style:
                          TextStyle(color: AppColors.primaryDark, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(text: 'Guardar cambios', onPressed: _guardar),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}