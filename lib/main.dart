//import 'package:pruebasipaso/login/login.dart';
//import 'package:pruebasipaso/screens/Lugares/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:pruebasipaso/screens/Usuarios/LoginPage.dart';
// ignore: unused_import


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenido',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 110, 9, 2)), // Corregido: se utiliza Colors.red como seedColor
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 150, 8, 41)), // Cambiar el color del texto en el AppBar a negro
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}