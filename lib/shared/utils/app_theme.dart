import 'package:flutter/material.dart';

const Color _customColor = Colors.amber;

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _customColor,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.amber.shade50,
        surfaceTintColor: Colors.amber.shade600,
        indicatorColor: Colors.amber.shade400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade700),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _customColor,
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.amber.shade800,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.white70),
        fillColor: Colors.grey.shade800,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade800),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade800),
        ),
      ),
    );
  }
}
