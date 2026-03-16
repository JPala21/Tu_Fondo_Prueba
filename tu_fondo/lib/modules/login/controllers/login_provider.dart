import 'package:flutter/material.dart';

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
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
