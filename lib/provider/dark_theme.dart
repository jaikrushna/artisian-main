import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xffD1A2FF),
    backgroundColor: Color(0xff200D31),
    indicatorColor: Color(0xffD399E6),
    hintColor: Color(0xff341950),
    highlightColor: Color(0xff951B80),
    hoverColor: Color(0xff3A3A3B),
    focusColor: Colors.white,
    disabledColor: Color(0xff0B0822),
    cardColor: Color(0xff331241),
    canvasColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white,
    ));
