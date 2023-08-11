import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Color(0xFF6200EE), // Deep Purple
  backgroundColor: Color(0xFFFCE4EC), // Pink
  indicatorColor: Colors.white,
  hintColor: Color(0xFF90CAF9), // Light Blue
  highlightColor: Color(0xFFFFF176), // Yellow
  hoverColor: Color(0xFF9FA8DA), // Indigo
  focusColor: Colors.black,
  disabledColor: Color(0xFFF5F4F6), // Light version of Color(0xff0B0822)
  cardColor: Colors.white,
  canvasColor: Color(0xffA99BB2),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
  textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.black),
);
