import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class SessionService {
  static const _keyUser = "session_user";

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    String json = jsonEncode(user.toMap());

    await prefs.setString(_keyUser, json);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_keyUser);

    if (data == null) return null;

    return User.fromMap(jsonDecode(data));
  }

  static Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyUser);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
