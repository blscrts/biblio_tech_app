import 'package:flutter/material.dart';

/// Modelo de libro
class Libro {
  final String titulo;
  final String autor;
  final String categoria;
  final String estado; // 'Prestado', 'Devuelto' o 'Vencido'
  final String? usuario;
  final DateTime? fechaPrestamo;
  final DateTime? fechaDevolucion;

  const Libro({
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.estado,
    this.usuario,
    this.fechaPrestamo,
    this.fechaDevolucion,
  });
}

class LibrosScreen extends StatefulWidget {
  const LibrosScreen({super.key});

  @override
  State<LibrosScreen> createState() => _LibrosScreenState();
}

class _LibrosScreenState extends State<LibrosScreen> {
  // Color principal (cambiar por AppColors cuando confirmes el nombre)
  static const Color _colorPrincipal = Color(0xFF0B7BD9);

  final List<Libro> _libros = [
    Libro(
      titulo: 'Cuentos de Barro',
      autor: 'Salomón Ibarra Mayorga',
      categoria: 'Literatura',
      estado: 'Devuelto',
      usuario: 'María Torres',
      fechaPrestamo: DateTime(2026, 10, 15),
      fechaDevolucion: DateTime(2026, 10, 29),
    ),
    Libro(
      titulo: 'El Caballero de la Armadura Oxidada',
      autor: 'Robert Fisher',
      categoria: 'Superación',
      estado: 'Prestado',
      usuario: 'Juan Pérez',
      fechaPrestamo: DateTime(2026, 11, 10),
      fechaDevolucion: DateTime(2026, 11, 24),
    ),
    Libro(
      titulo: 'Matemática Financiera',
      autor: 'Enrique Baca',
      categoria: 'Académico',
      estado: 'Vencido',
      usuario: 'Luis Ramírez',
      fechaPrestamo: DateTime(2026, 10, 20),
      fechaDevolucion: DateTime(2026, 11, 3),
    ),
  ];

  static const List<String> _estados = [
    'Todos',
    'Devuelto',
    'Prestado',
    'Vencido',
  ];

  String _busqueda = '';
  String _categoriaSeleccionada = 'Todas';
  String _estadoSeleccionado = 'Todos';

  List<String> get _categorias {
    final set = _libros.map((l) => l.categoria).toSet().toList()..sort();
    return ['Todas', ...set];
  }

  List<Libro> get _librosFiltrados {
    return _libros.where((libro) {
      final texto = _busqueda.toLowerCase();
      final coincideTexto =
          libro.titulo.toLowerCase().contains(texto) ||
          libro.autor.toLowerCase().contains(texto);
      final coincideCategoria =
          _categoriaSeleccionada == 'Todas' ||
          libro.categoria == _categoriaSeleccionada;
      final coincideEstado =
          _estadoSeleccionado == 'Todos' || libro.estado == _estadoSeleccionado;
      return coincideTexto && coincideCategoria && coincideEstado;
    }).toList();
  }

  Color _colorPorEstado(String estado) {
    switch (estado) {
      case 'Prestado':
        return Colors.orange;
      case 'Vencido':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  String _formatearFecha(DateTime? fecha) {
    if (fecha == null) return '-';
    final d = fecha.day.toString().padLeft(2, '0');
    final m = fecha.month.toString().padLeft(2, '0');
    return '$d/$m/${fecha.year}';
  }

  // Vuelve a la primera pantalla de la app (la interfaz de inicio)
  void _irAlInicio() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _escanearQR() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Escáner QR: próximamente')));
  }

  void _mostrarDetalle(Libro libro) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                libro.titulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _filaDetalle(Icons.person, 'Autor', libro.autor),
              _filaDetalle(Icons.category, 'Categoría', libro.categoria),
              _filaDetalle(
                Icons.account_circle,
                'Usuario',
                libro.usuario ?? '-',
              ),
              _filaDetalle(
                Icons.event,
                'Fecha de préstamo',
                _formatearFecha(libro.fechaPrestamo),
              ),
              _filaDetalle(
                Icons.event_available,
                'Fecha de devolución',
                _formatearFecha(libro.fechaDevolucion),
              ),
              _filaDetalle(Icons.info, 'Estado', libro.estado),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _filaDetalle(IconData icono, String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icono, size: 20, color: _colorPrincipal),
          const SizedBox(width: 10),
          Text(
            '$etiqueta: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }

  Widget _barraFiltros(
    List<String> opciones,
    String seleccionado,
    ValueChanged<String> alCambiar,
  ) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: opciones.map((op) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(op),
              selected: seleccionado == op,
              selectedColor: _colorPrincipal.withValues(alpha: 0.2),
              onSelected: (_) => alCambiar(op),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final libros = _librosFiltrados;

    return Scaffold(
      // Logo BiblioGest: al tocarlo regresa a la interfaz de inicio
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _colorPrincipal,
        foregroundColor: Colors.white,
        title: InkWell(
          onTap: _irAlInicio,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.menu_book, size: 30),
                SizedBox(width: 8),
                Text(
                  'BiblioGest',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              onChanged: (valor) => setState(() => _busqueda = valor),
              decoration: InputDecoration(
                hintText: 'Buscar por título o autor',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          _barraFiltros(
            _categorias,
            _categoriaSeleccionada,
            (v) => setState(() => _categoriaSeleccionada = v),
          ),
          _barraFiltros(
            _estados,
            _estadoSeleccionado,
            (v) => setState(() => _estadoSeleccionado = v),
          ),
          Expanded(
            child: libros.isEmpty
                ? const Center(child: Text('No se encontraron libros'))
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: libros.length,
                    itemBuilder: (context, index) {
                      final libro = libros[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          onTap: () => _mostrarDetalle(libro),
                          leading: Icon(
                            Icons.book,
                            size: 40,
                            color: _colorPrincipal,
                          ),
                          title: Text(
                            libro.titulo,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('Autor: ${libro.autor}'),
                              Text('Categoría: ${libro.categoria}'),
                            ],
                          ),
                          trailing: Chip(
                            label: Text(
                              libro.estado,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: _colorPorEstado(libro.estado),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _escanearQR,
        backgroundColor: _colorPrincipal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Escanear QR'),
      ),
    );
  }
}
