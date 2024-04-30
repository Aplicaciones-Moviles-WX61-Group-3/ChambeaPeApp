import 'package:flutter/material.dart';

class WorkersView extends StatelessWidget {
  const WorkersView({super.key});

  static const String routeName = 'workers_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Workers'),
      ),
    );
  }
}