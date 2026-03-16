import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class AuthServices {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<User>> getAllUserAccounts() async {
    try {
      CustomLoading.show();
      final snapshot = await firestore.collection('client_model').get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
    } catch (e) {
      return [];
    } finally {
      CustomLoading.dismiss();
    }
  }

  static Future<bool> registerUser(Map<String, dynamic> data) async {
    try {
      CustomLoading.show("Registrando...");

      final cedulaQuery = await firestore
          .collection('client_model')
          .where('cedula', isEqualTo: data['cedula'])
          .limit(1)
          .get();

      if (cedulaQuery.docs.isNotEmpty) {
        CustomLoading.showError('El usuario ya se encuentra registrado');
      }

      await firestore.collection('client_model').add(data);

      return true;
    } catch (e) {
      CustomLoading.showError("Problema al guardar: ${e.toString()}");
      return false;
    } finally {
      CustomLoading.dismiss();
    }
  }

  static Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      CustomLoading.show('Ingresando...');

      final query = await firestore
          .collection('client_model')
          .where('email', isEqualTo: email.trim())
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return null;
      }

      final data = query.docs.first.data();

      if (data['password'] != password) {
        return null;
      }

      return User.fromMap(data);
    } catch (e) {
      return null;
    } finally {
      CustomLoading.dismiss();
    }
  }
}
