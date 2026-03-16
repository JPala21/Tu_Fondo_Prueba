import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/modules/login/services/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void updateObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void findUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final value = await AuthServices.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (value == null) {
      CustomLoading.showError("Usuario y/o Contraseña Incorrecta");
      return;
    }
    if (!context.mounted) return;

    if (value.rol == 'admin') {
      Navigator.pushReplacementNamed(context, 'admin');
      return;
    }

    context.pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
