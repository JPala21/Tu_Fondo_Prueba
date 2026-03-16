import 'package:flutter/material.dart';

ColorScheme modeLight() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0052CC), 
    onPrimary: Colors.white,
    secondary: Color(0xFF00875A), 
    onSecondary: Colors.white,
    surface: Color(0xFFF4F5F7),
    onSurface: Color(0xFF172B4D),
    error: Color(0xFFDE350B),
    onError: Colors.white,
  );
}

ColorScheme modeDark() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 255, 255, 255),
    onPrimary: Color(0xFF0747A6),
    secondary: Color(0xFF36B37E), 
    onSecondary: Colors.black,
    surface: Color.fromARGB(255, 25, 47, 83),
    onSurface: Color(0xFFEBECF0),
    error: Color(0xFFFF5630),
    onError: Colors.white,
  );
}
