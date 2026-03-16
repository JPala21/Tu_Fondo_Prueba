import 'package:flutter/material.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/modules/admin/widgets/admin_button_sheet.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';

import 'package:tu_fondo/modules/home/services/fondo_service.dart';

class AdminProvider extends ChangeNotifier {
  TextEditingController controllerFind = .new();
  List<FondoModel> list = [];

  void filterFondos(String text) async {
    list = await FondoService.getFondos(query: text);
    notifyListeners();
  }

  Future<void> saveFondo(Map<String, dynamic> data, String? id) async {
    try {
      if (id == null) {
        await FondoService.create(data);
      } else {
        await FondoService.update(id, data);
      }
    } catch (e) {
      CustomLoading.showError("Error al guardar fondo: $e");
    } finally {
      filterFondos('');
    }
  }

  Future<void> deleteFondo(String id) async {
    try {
      await FondoService.delete(id);
    } catch (e) {
      CustomLoading.showError("Error al eliminar fondo: $e");
    } finally {
      filterFondos('');
    }
  }

    void showEditor(BuildContext context, FondoModel? fondo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AdminFondoSheet(
        fondo: fondo,
        onPressed: (data) async {
          await saveFondo(data, fondo?.id);
        },
      ),
    );
  }
}
