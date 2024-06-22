import 'package:flutter/material.dart';

class PostulationView extends StatelessWidget {

  static const String routeName = 'postulation_view';
  const PostulationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Postulaciones'),
      ),
      body: const Center(
        child: Text('Postulaciones'),
      ),
    );
  }
}