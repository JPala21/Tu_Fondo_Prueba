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

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs
          .map((doc) => FondoModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      CustomLoading.showError("Error al cargar fondos");
      return [];
    } finally {
      CustomLoading.dismiss();
    }
  }
}
