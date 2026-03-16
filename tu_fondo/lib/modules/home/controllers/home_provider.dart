import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';
import 'package:tu_fondo/modules/home/models/transaction_model.dart';
import 'package:tu_fondo/modules/home/services/fondo_service.dart';
import 'package:tu_fondo/modules/home/services/transaction_service.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController controllerFind = TextEditingController();
  List<FondoModel> list = [];
  List<TransactionModel> historial = [];

  /// Guarda las inversiones activas localmente
  Map<String, bool> activeInvestments = {};

  String? currentUserId;
  bool isInitialized = false;

  /// Inicializa el proveedor con el usuario
  Future<void> init(String cedula) async {
    currentUserId = cedula;
    await fetchAllData();
  }

  /// Obtiene todos los fondos y sincroniza inversiones activas
  Future<void> fetchAllData({String query = ''}) async {
    debugPrint("===== FETCH ALL DATA =====");
    debugPrint("Usuario actual: $currentUserId");

    // 1️⃣ Traemos los fondos desde Firestore / API
    list = await FondoService.getFondos(query: query);
    debugPrint("Fondos cargados: ${list.length}");

    // 2️⃣ Obtenemos las transacciones activas desde Firestore
    if (currentUserId != null && currentUserId!.isNotEmpty) {
      final snapshot = await FirebaseFirestore.instance
          .collection('transaction_model')
          .where('userId', isEqualTo: currentUserId)
          .where('status', isEqualTo: 'active')
          .get();

      debugPrint("Documentos activos: ${snapshot.docs.length}");

      // ✅ Merge: conservamos inversiones optimistas y agregamos las reales de Firebase
      final Map<String, bool> updatedInvestments = Map.from(activeInvestments);

      for (var doc in snapshot.docs) {
        final fundId = doc.data()['fundId'];
        if (fundId != null) {
          updatedInvestments[fundId] = true;
        }
      }

      activeInvestments = updatedInvestments;
    }

    debugPrint("activeInvestments => $activeInvestments");

    notifyListeners();
  }

  /// Verifica si un fondo ya está invertido
  bool isInvested(String fundId) {
    return activeInvestments[fundId] == true;
  }

  /// Filtra los fondos por texto
  void filterFondos(String text) async {
    await fetchAllData(query: text);
  }

  /// Invertir dinero en un fondo
  Future<void> investMoney({
    required BuildContext context,
    required FondoModel fondo,
    required User user,
    required bool isSms,
  }) async {
    try {
      // 🔹 Mostramos loading
      CustomLoading.show('Procesando inversión...');

      // 1️⃣ Actualización optimista
      activeInvestments[fondo.id] = true;
      notifyListeners();

      // 2️⃣ Llamada al servicio que hace la inversión
      await TransactionService.investMoney(
        fund: fondo,
        user: user,
        context: context,
        isSms: isSms,
      );

      // 3️⃣ Sincronizamos con Firebase
      await fetchAllData();

      // 4️⃣ Mensaje de éxito
      CustomLoading.showSuccess("Inversión realizada ✅");
    } catch (e) {
      // revertimos cambio si falla
      activeInvestments[fondo.id] = false;
      notifyListeners();
      CustomLoading.showError('Error al invertir: $e');
    } finally {
      CustomLoading.dismiss();
    }
  }
// En HomeProvider.dart
  void clear() {
    list = [];
    historial = [];
    activeInvestments = {};
    currentUserId = null;
    isInitialized = false;
    controllerFind.clear();
    notifyListeners();
  }
// Dentro de HomeProvider
  Future<void> fetchUserTransactions() async {
    if (currentUserId == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('transaction_model')
        .where('userId', isEqualTo: currentUserId)
        .get();

    historial = snapshot.docs.map((doc) {
      final data = doc.data();

      // Si no tiene 'date', usamos la fecha actual
      final date = data['date'] != null
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now();

      // Si no tiene 'amount', ponemos 0
      final amount = (data['amount'] ?? 0).toDouble();

      // Construimos TransactionModel con los valores por defecto
      return TransactionModel.fromMap({
        ...data,
        'date': date,
        'amount': amount,
        'status': data['status'] ?? 'active', // default active
      }, doc.id);
    }).toList();

    // Ordenamos de la más reciente a la más antigua
    historial.sort((a, b) => b.date.compareTo(a.date));

    // Actualizamos el mapa de inversiones activas
    activeInvestments = {};
    for (var tx in historial) {
      if (tx.status == 'active') activeInvestments[tx.fundId] = true;
    }

    notifyListeners();
  }
  /// Cancelar inversión en un fondo
  Future<void> cancelInvestment({
    required BuildContext context,
    required FondoModel fondo,
    required User user,
  }) async {
    try {
      // 🔹 Mostramos loading
      CustomLoading.show('Cancelando inversión...');

      // 1️⃣ Actualización optimista
      activeInvestments.remove(fondo.id);
      notifyListeners();

      // 2️⃣ Llamada al servicio que cancela la inversión
      await TransactionService.cancelInvestment(
        fund: fondo,
        user: user,
        context: context,
      );

      // 3️⃣ Actualizamos datos del usuario si es necesario
      if (context.mounted) {
        await context.read<SessionProvider>().refreshUser();
      }

      // 4️⃣ Sincronizamos con Firebase
      await fetchAllData();

      // 5️⃣ Mensaje de éxito
      CustomLoading.showSuccess("Inversión cancelada ✅");
    } catch (e) {
      // revertimos cambio si falla
      activeInvestments[fondo.id] = true;
      notifyListeners();
      CustomLoading.showError('Error al cancelar: $e');
    } finally {
      CustomLoading.dismiss();
    }


  }
}
