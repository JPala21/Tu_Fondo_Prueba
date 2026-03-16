import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/modules/login/services/auth_service.dart';

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
      "rol": "User",
      'money': '2500000'
    };
    final result = await AuthServices.registerUser(data);
    if(!context.mounted) return;
      
    if (result) {
      CustomLoading.showSuccess("Registro exitoso");
      context.pop();
    }
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
