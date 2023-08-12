import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xffD1A2FF),
  secondaryHeaderColor: const Color(0xffD399E6),
  backgroundColor: const Color(0xff200D31),
  indicatorColor: const Color(0xffD399E6),
  hintColor: const Color(0xff341950),
  highlightColor: const Color(0xff951B80),
  hoverColor: const Color(0xff3A3A3B),
  focusColor: Colors.white,
  disabledColor: const Color(0xff0B0822),
  cardColor: const Color(0xff331241),
  canvasColor: const Color(0xffD1A2FF),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0xffDED1FF),
  ),
);
