import 'package:flutter/material.dart';
import 'package:tu_fondo/global/services/session_service.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class SessionProvider extends ChangeNotifier {
  User? user;

  bool get isLogged => user != null;

  Future<void> loadSession() async {
    user =
        await SessionService.getUser(); 
    notifyListeners();
  }

  Future<void> login(User newUser) async {
    user = newUser;
    await SessionService.saveUser(newUser);
    notifyListeners();
  }

  Future<void> logout() async {
    await SessionService.logout(); 
    user = null;
    notifyListeners();
  }

  Future<void> refreshUser() async {
    if (user != null) {
      user = await SessionService.getUser();
      notifyListeners();
    }
  }

  Future<void> updateUserMoney(int newMoney) async {
    if (user != null) {
      user = User(
        cedula: user!.cedula,
        nombre: user!.nombre,
        apellido: user!.apellido,
        rol: user!.rol,
        email: user!.email,
        password: user!.password,
        money: newMoney,
      );

      await SessionService.saveUser(user!); 
      notifyListeners();
    }
  }
}
