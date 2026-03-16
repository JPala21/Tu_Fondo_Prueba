import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
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

    // 1. Mostrar loading mientras procesas
    CustomLoading.show();

    final user = await AuthServices.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (user == null) {
      CustomLoading.dismiss();
      CustomLoading.showError("Usuario y/o Contraseña Incorrecta");
      return;
    }

    if (!context.mounted) return;

    // 2. Esperamos a que la sesión se guarde en SharedPreferences
    await context.read<SessionProvider>().login(user);

    // 3. VERIFICACIÓN: Esperamos a que el HomeProvider descargue los datos de Firebase

    debugPrint("LOG: Iniciando descarga de datos para cedula: ${user.cedula}");
    debugPrint("LOG: Datos de usuario cargados en HomeProvider correctamente.");

    CustomLoading.dismiss();

    // 4. Ahora sí, navegamos sabiendo que los datos ya están en el Provider
    if (user.rol == 'admin') {
      context.push('/admin');
    } else {
      context.go('/');
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
