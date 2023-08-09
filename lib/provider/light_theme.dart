import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Color(0xff0B0822),
  backgroundColor: Color(0xffD1A2FF),
  indicatorColor: Colors.white,
  hintColor: Color(0xffEECED3),
  highlightColor: Color(0xffFCE192),
  hoverColor: Color(0xffB6B5D8),
  focusColor: Colors.black,
  disabledColor: Color(0xffE9DCE5),
  cardColor: Colors.white,
  canvasColor: Colors.grey[50],
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
  textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.black),
);
