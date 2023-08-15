import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primarySwatch: lightSwatch,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber[800]!),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ))
    )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    circularTrackColor: Colors.white,
    linearTrackColor: lightSwatch.shade600
  )
);

final darkTheme = ThemeData(
    primarySwatch: _darkSwatch,
    brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber[800]!),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ))
      )
  ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: Colors.white,
        linearTrackColor: lightSwatch.shade600
    )
);

final lightSwatch = MaterialColor(
    const Color(0xFF009241).value, _customLightColorMap);


final _darkSwatch = MaterialColor(
    const Color(0xFF32a766).value, _customDarkColorMap);

const _customLightColorMap = {
  50: Color(0xFF99d3b3),
  100: Color(0xFF66bd8d),
  200: Color(0xFF32a766),
  300: Color(0xFF00df63),
  400: Color(0xFF00c558),
  500: Color(0xFF00ac4c),
  600: Color(0xFF009241),
  700: Color(0xFF007936),
  800: Color(0xFF005f2a),
  900: Color(0xFF00461f),
};

const _customDarkColorMap = {
  50: Color(0xFF99d3b3),
  100: Color(0xFF66bd8d),
  200: Color(0xFF32a766),
  300: Color(0xFF00df63),
  400: Color(0xFF00c558),
  500: Color(0xFF00ac4c),
  600: Color(0xFF009241),
  700: Color(0xFF007936),
  800: Color(0xFF005f2a),
  900: Color(0xFF00461f),
};