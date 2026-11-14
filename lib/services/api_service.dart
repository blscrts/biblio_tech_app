import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/institucion.dart';
import '../models/usuario.dart';

/// Error legible para mostrar al usuario.
class ApiException implements Exception {
  ApiException(this.mensaje);

  final String mensaje;

  @override
  String toString() => mensaje;
}

/// Único lugar de la app que habla con la API REST.
/// Las pantallas llaman a estos métodos y no saben nada de HTTP.
class ApiService {
  ApiService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? 'http://localhost:3000';

  final http.Client _client;
  final String _baseUrl;

  static const _headers = {'Content-Type': 'application/json'};

  /// GET /instituciones
  Future<List<Institucion>> obtenerInstituciones() async {
    final datos = await _enviar(() => _client.get(_uri('/instituciones')));
    return (datos as List)
        .map((e) => Institucion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /usuarios/{id}
  Future<Usuario> obtenerUsuario(int id) async {
    final datos = await _enviar(() => _client.get(_uri('/usuarios/$id')));
    return Usuario.fromJson(datos as Map<String, dynamic>);
  }

  /// PUT /usuarios/{id}
  Future<Usuario> actualizarInstitucion(int id, int institucionId) async {
    final datos = await _enviar(() => _client.put(
          _uri('/usuarios/$id'),
          headers: _headers,
          body: jsonEncode({'institucionId': institucionId}),
        ));
    return Usuario.fromJson(datos as Map<String, dynamic>);
  }

  Uri _uri(String ruta) => Uri.parse('$_baseUrl$ruta');

  /// Ejecuta la petición, revisa el código de respuesta y decodifica el JSON.
  Future<dynamic> _enviar(Future<http.Response> Function() peticion) async {
    final http.Response respuesta;
    try {
      respuesta = await peticion();
    } catch (_) {
      throw ApiException('No se pudo conectar con el servidor');
    }

    final cuerpo = utf8.decode(respuesta.bodyBytes);
    final datos = cuerpo.isEmpty ? null : jsonDecode(cuerpo);

    if (respuesta.statusCode >= 400) {
      final mensaje = (datos is Map && datos['error'] is String)
          ? datos['error'] as String
          : 'Error del servidor (${respuesta.statusCode})';
      throw ApiException(mensaje);
    }
    return datos;
  }
}