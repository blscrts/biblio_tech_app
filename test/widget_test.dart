import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biblio_tech_app/main.dart';

void main() {
  testWidgets('La pantalla de inicio muestra bienvenida y 3 botones', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('¡Bienvenido a BiblioGest!'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Catálogo de Libros'), findsOneWidget);
    expect(find.text('Mi Perfil'), findsOneWidget);
  });

  testWidgets('El botón Iniciar Sesión navega a Login', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Iniciar Sesión'));
    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsWidgets);
  });

  testWidgets('El botón Catálogo de Libros navega al catálogo', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Catálogo de Libros'));
    await tester.tap(find.text('Catálogo de Libros'));
    await tester.pumpAndSettle();
    expect(find.text('Catálogo de Libros'), findsWidgets);
  });

  testWidgets('El botón Mi Perfil navega al perfil', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Mi Perfil'));
    await tester.tap(find.text('Mi Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('Mi Perfil'), findsWidgets);
  });
}
