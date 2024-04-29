import 'package:chambeape/modules/0_login/login_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChambeaPe',
      theme: ThemeData(
        colorSchemeSeed: Colors.amber.shade700,
        
      ),
      home: const LoginWdget(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChambeaPe'),
      ),
      body: const Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}