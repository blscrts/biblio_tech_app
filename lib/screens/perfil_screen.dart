import 'package:flutter/material.dart';

import '../models/institucion.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_dropdown_field.dart';
import '../widgets/app_text_field.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/bibliogest_app_bar.dart';
import '../widgets/form_card.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_button.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key, this.api, this.usuarioId = 1});

  /// Servicio de la API. Si no se envía, usa el real.
  /// (Las pruebas envían uno falso para no depender del servidor.)
  final ApiService? api;

  /// Usuario que se muestra. Más adelante vendrá del login.
  final int usuarioId;

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late final ApiService _api = widget.api ?? ApiService();

  final _nombresCtrl = TextEditingController();
  final _apellidosCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController(text: '12345678');

  List<Institucion> _instituciones = [];
  Institucion? _institucion;

  bool _cargando = true;
  bool _guardando = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  void dispose() {
    _nombresCtrl.dispose();
    _apellidosCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _cargarDatos() async {
    setState(() {
      _cargando = true;
      _error = null;
    });

    try {
      final instituciones = await _api.obtenerInstituciones();
      final usuario = await _api.obtenerUsuario(widget.usuarioId);
      if (!mounted) return;

      Institucion? seleccionada;
      for (final i in instituciones) {
        if (i.id == usuario.institucionId) seleccionada = i;
      }

      setState(() {
        _instituciones = instituciones;
        _institucion = seleccionada;
        _nombresCtrl.text = usuario.nombres;
        _apellidosCtrl.text = usuario.apellidos;
        _cargando = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.mensaje;
        _cargando = false;
      });
    }
  }

  void _mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _guardar() async {
    final institucion = _institucion;
    if (institucion == null) {
      _mostrarMensaje('Selecciona tu institución o espacio comunitario');
      return;
    }

    setState(() => _guardando = true);
    try {
      await _api.actualizarInstitucion(widget.usuarioId, institucion.id);
      if (!mounted) return;
      _mostrarMensaje('Cambios guardados');
    } on ApiException catch (e) {
      if (!mounted) return;
      _mostrarMensaje(e.mensaje);
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: const BiblioGestAppBar(),
      body: SafeArea(
        child: Center(
          child: _cargando
              ? const CircularProgressIndicator()
              : _error != null
                  ? _vistaError()
                  : _formulario(),
        ),
      ),
    );
  }

  Widget _vistaError() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: FormCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: AppColors.primaryDark),
            const SizedBox(height: 12),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            PrimaryButton(text: 'Reintentar', onPressed: _cargarDatos),
          ],
        ),
      ),
    );
  }

  Widget _formulario() {
    return SingleChildScrollView(
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
            AppDropdownField<Institucion>(
              label: 'Institución o Espacio Comunitario',
              items: _instituciones,
              value: _institucion,
              itemLabel: (i) => i.nombre,
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
                style: TextStyle(color: AppColors.primaryDark, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              text: _guardando ? 'Guardando...' : 'Guardar cambios',
              onPressed: _guardando ? null : _guardar,
            ),
          ],
        ),
      ),
    );
  }
}