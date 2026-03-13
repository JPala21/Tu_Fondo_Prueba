import 'package:flutter/material.dart';
class SelectorModeProvider extends ChangeNotifier {
  ThemeMode themeMode;
  bool statusMode;


  SelectorModeProvider({
    this.themeMode = ThemeMode.light,
    this.statusMode = false,
  });

  void selecModeColor() {
    statusMode = !statusMode;
    if (statusMode) themeMode = ThemeMode.dark;

    if (!statusMode) themeMode = ThemeMode.light;

    notifyListeners();
  }
}
