import 'package:flutter/material.dart';

class OptionsView extends StatelessWidget {

  static const String routeName = 'options_view';

  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Options'),
          ],
        ),
      ),
    );
  }
}