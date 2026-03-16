import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoading {
  static void init() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = const Color(0xFF22C55E)
      ..backgroundColor = const Color(0xFF0B1120)
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.black.withAlpha(180)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show([String? status]) {
    EasyLoading.show(status: status ?? 'Cargando...');
  }

  // Quita el loader
  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }

  static void showError(String message) {
    EasyLoading.showError(message);
  }

  static void showInfo(String message) {
    EasyLoading.showInfo(message);
  }
}
