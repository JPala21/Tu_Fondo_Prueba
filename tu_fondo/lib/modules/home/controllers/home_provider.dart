import 'package:flutter/material.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';
import 'package:tu_fondo/modules/home/services/fondo_service.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController controllerFind = .new();
  List<FondoModel> list = [];

  HomeProvider();

  void filterFondos(String text) async {
    list = await FondoService.getFondos(query: text);
    notifyListeners();
  }
}
