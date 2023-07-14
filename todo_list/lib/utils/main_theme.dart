import 'package:flutter/material.dart';

const Color defaultBackgroundColor = Colors.white;
const Color defaultAppBarBackgroundColor = Colors.white;
const Color defaultPrimaryColor = Color.fromRGBO(19, 99, 165, 1);

class MainTheme {
  static final defaultTheme = ThemeData(
    scaffoldBackgroundColor: defaultBackgroundColor,
    splashColor: defaultPrimaryColor,
    textTheme: _textThemes(),
    inputDecorationTheme: _inputDecorationTheme(),
    appBarTheme: _appBarTheme(),
    colorScheme: _colorSchemes(),
  );

  static _colorSchemes() {
    return const ColorScheme.dark(
      primary: defaultPrimaryColor,
      background: defaultBackgroundColor,
      error: Colors.red,
    );
  }

  static _textThemes() {
    return const TextTheme(
      headlineMedium: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      labelSmall: TextStyle(
          color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  static _inputDecorationTheme() {
    return const InputDecorationTheme(
      contentPadding: EdgeInsets.only(left: 8),
      fillColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  static _appBarTheme() {
    return const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        backgroundColor: defaultAppBarBackgroundColor,
        elevation: 0);
  }
}
