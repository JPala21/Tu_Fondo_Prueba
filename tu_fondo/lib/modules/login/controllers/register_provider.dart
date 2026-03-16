import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final cedulaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> send(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final data = {
      "nombre": nombreController.text.trim(),
      "apellido": apellidoController.text.trim(),
      "cedula": cedulaController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "rol": "cliente",
    };

  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    cedulaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
