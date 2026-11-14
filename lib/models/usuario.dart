/// Datos de un usuario (vienen de la API).
class Usuario {
  const Usuario({
    required this.id,
    required this.nombres,
    required this.apellidos,
    this.institucionId,
  });

  final int id;
  final String nombres;
  final String apellidos;
  final int? institucionId; // null si todavía no eligió institución

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      institucionId: json['institucionId'] as int?,
    );
  }
}