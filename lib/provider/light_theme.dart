import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFF6200EE), // Deep Purple
  backgroundColor: const Color(0xFFFCE4EC), // Pink
  indicatorColor: Colors.white,
  hintColor: const Color(0xFF90CAF9), // Light Blue
  highlightColor: const Color(0xFFFFF176), // Yellow
  hoverColor: const Color(0xFF9FA8DA), // Indigo
  focusColor: Colors.black,
  disabledColor: const Color(0xFFF5F4F6), // Light version of Color(0xff0B0822)
  cardColor: Colors.white,
  canvasColor: const Color(0xffA99BB2),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
  ),
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Colors.black),
);
