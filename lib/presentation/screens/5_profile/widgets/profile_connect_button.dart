import 'package:flutter/material.dart';

class ConnectButton extends StatelessWidget {
  final TextTheme text;

  const ConnectButton({
    super.key, 
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5), // Ajusta el radio del borde aquí
          ),
        ),
        onPressed: () {
          // TODO Implementar la funcionalidad de chatear aquí
        },
        child: Text('Chatear',
            style: text.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
