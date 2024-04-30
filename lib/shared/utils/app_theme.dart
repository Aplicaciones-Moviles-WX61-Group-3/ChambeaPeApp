import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.amber.shade700,
        secondary: Colors.amber.shade400,
        background: Colors.white,
      ),
      brightness: Brightness.light,
      primaryColor: Colors.amber.shade700,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.amber.shade50,
        surfaceTintColor: Colors.amber.shade600,
        indicatorColor: Colors.amber.shade400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.black87),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade700),
        ),
      ),
      canvasColor: Colors.amber.shade50,
      primarySwatch: Colors.amber,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber.shade700),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.amber.shade700,
        secondary: Colors.amber.shade700,
        background: Colors.grey.shade900,
      ),
      brightness: Brightness.dark,
      primaryColor: Colors.amber.shade700,
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
      canvasColor: Colors.grey.shade900, // ca
      primarySwatch: Colors.amber,

      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: Colors.white70),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber.shade700),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),

      
    );

  }
}
