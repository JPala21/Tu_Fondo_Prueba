import 'package:flutter/material.dart';

ColorScheme modeLight() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
    error: AppColors.errorLight,
    onError: Colors.white,
  );
}

ColorScheme modeDark() {
  return ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    onPrimary: Colors.black,
    secondary: AppColors.secondaryDark,
    onSecondary: Colors.black,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    error: AppColors.errorDark,
    onError: Colors.black,
  );
}

class AppColors {
  // Primarios
  static const Color primaryLight = Color(0xFFB8962E);
  static const Color primaryDark = Color(0xFFD4AF37);

  // Secundarios
  static const Color secondaryLight = Color(0xFF00A152);
  static const Color secondaryDark = Color(0xFF00C853);

  // Neutros
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF161B22);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1F2A);
  static const Color onSurfaceLight = Color(0xFF1B1F23);
  static const Color onSurfaceDark = Color(0xFFE6EDF3);

  // Errores
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color errorDark = Color(0xFFFF5252);

  // Paleta adicional
  static const Color successLight = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF81C784);

  static const Color warningLight = Color(0xFFFFC107);
  static const Color warningDark = Color(0xFFFFD54F);

  static const Color infoLight = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF64B5F6);

  static const Color accentLight = Color(0xFF00BCD4);
  static const Color accentDark = Color(0xFF26C6DA);
}
