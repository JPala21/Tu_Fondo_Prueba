import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';

class FondoService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<FondoModel>> getFondos({String? query}) async {
    try {
      CustomLoading.show();
      Query<Map<String, dynamic>> ref = _firestore.collection('fondos');

      if (query != null && query.isNotEmpty) {
        ref = ref
            .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
            .where('name', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff');
      }

      final snapshot = await ref.get();
      return snapshot.docs
          .map((doc) => FondoModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      CustomLoading.showError("Error al cargar fondos");
      return [];
    } finally {
      CustomLoading.dismiss();
    }
  }

  static Future<void> create(Map<String, dynamic> data) async {
    try {
      CustomLoading.show();
      await _firestore.collection('fondos').add(data);

      CustomLoading.showSuccess("Fondo creado correctamente ✅");
    } catch (e) {
      CustomLoading.showError("Error al crear fondo");
    } finally {
      CustomLoading.dismiss();
    }
  }

  static Future<void> update(String id, Map<String, dynamic> data) async {
    try {
      CustomLoading.show();
      await _firestore.collection('fondos').doc(id).update(data);

      CustomLoading.showSuccess("Fondo actualizado correctamente ✏️");
    } catch (e) {
      CustomLoading.showError("Error al actualizar fondo");
    } finally {
      CustomLoading.dismiss();
    }
  }

  static Future<void> delete(String id) async {
    try {
      CustomLoading.show();
      await _firestore.collection('fondos').doc(id).delete();

      CustomLoading.showSuccess("Fondo eliminado correctamente 🗑️");
    } catch (e) {
      CustomLoading.showError("Error al eliminar fondo");
    } finally {
      CustomLoading.dismiss();
    }
  }
}
