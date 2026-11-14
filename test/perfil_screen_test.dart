// Pruebas del módulo "Perfil de usuario" de BiblioGest.
// Ejecutar con: flutter test test/perfil_screen_test.dart --reporter expanded
//
// IMPORTANTE: si el nombre de tu proyecto en pubspec.yaml (campo "name:")
// no es biblio_tech_app, cambia el nombre del paquete en los imports.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biblio_tech_app/screens/perfil_screen.dart';
import 'package:biblio_tech_app/widgets/password_field.dart';
import 'package:biblio_tech_app/widgets/primary_button.dart';

/// Monta la pantalla con tamaño de celular para que todo sea visible.
Future<void> cargarPerfil(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 2700); // 360 x 900 lógicos
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const MaterialApp(home: PerfilScreen()));
}

/// Busca el TextField interno que muestra el texto indicado.
Finder campoConTexto(String texto) => find.byWidgetPredicate(
      (w) => w is TextField && w.controller?.text == texto,
    );

void main() {
  group('PerfilScreen', () {
    testWidgets('CP-01: muestra los elementos principales de la pantalla',
        (tester) async {
      await cargarPerfil(tester);

      expect(find.text('BiblioGest'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('Cambiar foto de usuario'), findsOneWidget);
      expect(find.text('Cambiar contraseña'), findsOneWidget);
      expect(find.text('Guardar cambios'), findsOneWidget);
    });

    testWidgets('CP-02: nombres y apellidos son solo lectura',
        (tester) async {
      await cargarPerfil(tester);

      final nombres = tester.widget<TextField>(campoConTexto('Nombres'));
      final apellidos = tester.widget<TextField>(campoConTexto('Apellidos'));

      expect(nombres.readOnly, isTrue);
      expect(apellidos.readOnly, isTrue);
    });

    testWidgets('CP-03: la lista de instituciones muestra las 6 opciones',
        (tester) async {
      await cargarPerfil(tester);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      expect(find.text('Biblioteca municipal'), findsOneWidget);
      expect(find.text('Biblioteca escolar'), findsOneWidget);
      expect(find.text('Biblioteca universitaria'), findsOneWidget);
      expect(find.text('Centro comunitario'), findsOneWidget);
      expect(find.text('Biblioteca parroquial'), findsOneWidget);
      expect(find.text('Otro'), findsOneWidget);
    });

    testWidgets('CP-04: al elegir una institución queda seleccionada',
        (tester) async {
      await cargarPerfil(tester);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Centro comunitario').last);
      await tester.pumpAndSettle();

      // Con el menú cerrado, solo queda el valor dentro del campo.
      expect(find.text('Centro comunitario'), findsOneWidget);
      expect(find.text('Biblioteca municipal'), findsNothing);
    });

    testWidgets('CP-05: la contraseña inicia oculta y el ojito la alterna',
        (tester) async {
      await cargarPerfil(tester);

      final textField = find.descendant(
        of: find.byType(PasswordField),
        matching: find.byType(TextField),
      );

      // Estado inicial: oculta
      expect(tester.widget<TextField>(textField).obscureText, isTrue);

      // Mostrar
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(tester.widget<TextField>(textField).obscureText, isFalse);

      // Ocultar de nuevo
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();
      expect(tester.widget<TextField>(textField).obscureText, isTrue);
    });

    testWidgets('CP-06: guardar sin institución muestra un aviso',
        (tester) async {
      await cargarPerfil(tester);

      await tester.tap(find.text('Guardar cambios'));
      await tester.pump();

      expect(
        find.text('Selecciona tu institución o espacio comunitario'),
        findsOneWidget,
      );
      expect(find.text('Cambios guardados'), findsNothing);
    });

    testWidgets('CP-07: guardar con institución confirma los cambios',
        (tester) async {
      await cargarPerfil(tester);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Biblioteca escolar').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Guardar cambios'));
      await tester.pump();

      expect(find.text('Cambios guardados'), findsOneWidget);
    });
  });

  group('Widget reutilizable', () {
    testWidgets('CP-08: PrimaryButton muestra su texto y ejecuta onPressed',
        (tester) async {
      var veces = 0;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PrimaryButton(text: 'Aceptar', onPressed: () => veces++),
        ),
      ));

      expect(find.text('Aceptar'), findsOneWidget);
      await tester.tap(find.text('Aceptar'));
      expect(veces, 1);
    });
  });
}