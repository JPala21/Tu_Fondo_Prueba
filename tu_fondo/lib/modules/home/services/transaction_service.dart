import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';
class TransactionService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> investMoney({
    required FondoModel fund,
    required User user,
    required bool isSms,
    required BuildContext context,
  }) async {
    try {
      CustomLoading.show('Procesando inversión...');

      // 1. Buscamos al usuario en 'client_model'
      final query = await _firestore
          .collection('client_model')
          .where('cedula', isEqualTo: user.cedula)
          .limit(1)
          .get();

      if (query.docs.isEmpty) throw Exception("Usuario no encontrado.");
      final userDoc = query.docs.first;
      final int currentMoney = (userDoc.data()['money'] ?? 0).toInt();

      // 2. Validación
      if (currentMoney < fund.minMoney) {
        throw Exception("Saldo insuficiente.");
      }

      // 3. Ejecutamos las escrituras
      await userDoc.reference.update({'money': currentMoney - fund.minMoney});

      // CORREGIDO: Usamos 'cedula' en lugar de 'userId'
await _firestore.collection('transaction_model').add({
        'userId': user.cedula,
        'fundId': fund.id,
        'fundName': fund.name,
        'amount': fund.minMoney,
        'status': 'active',
        'date': DateTime.now(),
        'notificationMethod': isSms ? 'SMS' : 'Email',
      });

      if (context.mounted) {
        CustomLoading.showSuccess('¡Inversión exitosa! ✅');
        await context.read<SessionProvider>().refreshUser();
      }
    } catch (e) {
      debugPrint("Error en inversión: $e");
      if (context.mounted)
        CustomLoading.showError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      CustomLoading.dismiss();
    }
  }
static Future<void> cancelInvestment({
    required FondoModel fund,
    required User user,
    required BuildContext context,
  }) async {
    try {
      CustomLoading.show('Cancelando...');

final snapshot = await _firestore
          .collection('transaction_model')
          .where('userId', isEqualTo: user.cedula)
          .where('fundId', isEqualTo: fund.id)
          .where('status', isEqualTo: 'active')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception("No se encontró inversión activa.");
      }

      final doc = snapshot.docs.first;
      final int amount = (doc.data()['amount'] ?? 0).toInt();

      await _firestore.runTransaction((transaction) async {
        transaction.update(doc.reference, {
          'status': 'cancelled',
          'cancelDate': DateTime.now(),
        });

        final clientQuery = await _firestore
            .collection('client_model')
            .where('cedula', isEqualTo: user.cedula)
            .limit(1)
            .get();

        final clientDoc = clientQuery.docs.first;
        final currentMoney = (clientDoc.data()['money'] ?? 0).toInt();

        transaction.update(clientDoc.reference, {
          'money': currentMoney + amount,
        });
      });

      if (context.mounted) {
        await context.read<SessionProvider>().refreshUser();
      }

      CustomLoading.showSuccess('Inversión cancelada ✅');
    } catch (e) {
      CustomLoading.showError('Error al cancelar: $e');
    } finally {
      CustomLoading.dismiss();
    }
  }
}
