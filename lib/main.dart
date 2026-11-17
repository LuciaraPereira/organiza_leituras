// Integrante: Luciara Pereira

import 'package:flutter/material.dart';
import 'tela_inicial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const rosaPrincipal = Color(0xFFD85A86);
    const rosaClaro = Color(0xFFFFE5EE);
    const fundoClaro = Color(0xFFFFF8FA);
    const vinho = Color(0xFF71344C);

    return MaterialApp(
      title: 'Organiza Leituras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: rosaPrincipal,
          primary: rosaPrincipal,
          secondary: vinho,
          surface: fundoClaro,
        ),
        scaffoldBackgroundColor: fundoClaro,
        appBarTheme: const AppBarTheme(
          backgroundColor: rosaPrincipal,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          color: rosaClaro,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: rosaPrincipal,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: rosaPrincipal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: rosaPrincipal,
              width: 2,
            ),
          ),
        ),
      ),
      home: const TelaInicial(),
    );
  }
}