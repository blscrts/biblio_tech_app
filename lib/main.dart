import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const BiblioGestApp());
}

class BiblioGestApp extends StatelessWidget {
  const BiblioGestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblio Gest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1E3A8A),
      ),
      home: const LoginScreen(),
    );
  }
}
