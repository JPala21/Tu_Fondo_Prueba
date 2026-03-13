import 'package:flutter/material.dart';

ColorScheme modeLight() {
  return const ColorScheme.light(
    primary: Color(0xFFB8962E), // Dorado más oscuro
    onPrimary: Color(0xFFFFFFFF),

    secondary: Color(0xFF00A152), // Verde mercado
    onSecondary: Color(0xFFFFFFFF),

    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1B1F23),

    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
  );
}

ColorScheme modeDark() {
  return const ColorScheme.dark(
    primary: Color(0xFFD4AF37), 
    onPrimary: Color(0xFF000000),

    secondary: Color(0xFF00C853),
    onSecondary: Color(0xFF000000),

    surface: Color(0xFF161B22),
    onSurface: Color(0xFFE6EDF3),

    error: Color(0xFFFF5252), 
    onError: Color(0xFF000000),
  );
}
