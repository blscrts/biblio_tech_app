/// Una institución o espacio comunitario (viene de la API).
class Institucion {
  const Institucion({required this.id, required this.nombre});

  final int id;
  final String nombre;

  /// Convierte el JSON que envía la API en un objeto Institucion.
  factory Institucion.fromJson(Map<String, dynamic> json) {
    return Institucion(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }

  // Dos instituciones son iguales si tienen el mismo id.
  // Lo necesita la lista desplegable para saber cuál está seleccionada.
  @override
  bool operator ==(Object other) => other is Institucion && other.id == id;

  @override
  int get hashCode => id.hashCode;
}