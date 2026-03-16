import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/loading.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class TransactionService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static double parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static Future<void> investMoney({
    required FondoModel fund,
    required User user,
    required bool isSms,
    required BuildContext context,
  }) async {
    try {
      CustomLoading.show('Procesando inversión...');

      // 1️⃣ Referencia directa al usuario
      final userDocRef = _firestore.collection('client_model').doc(user.cedula);

      await _firestore.runTransaction((transaction) async {
        final freshUser = await transaction.get(userDocRef);
        final double currentMoney = parseDouble(
          freshUser.data()?['money'] ?? 0,
        );

        if (currentMoney < fund.minMoney) {
          throw Exception("Saldo insuficiente.");
        }

        // Resta del dinero
        transaction.update(userDocRef, {'money': currentMoney - fund.minMoney});

        // Agregar transacción
        final newTxRef = _firestore.collection('transaction_model').doc();
        transaction.set(newTxRef, {
          'userId': user.cedula,
          'fundId': fund.id,
          'fundName': fund.name,
          'amount': fund.minMoney,
          'status': 'active',
          'date': DateTime.now(),
          'notificationMethod': isSms ? 'SMS' : 'Email',
        });
      });

      if (context.mounted) {
        CustomLoading.showSuccess('¡Inversión exitosa! ✅');
        await context.read<SessionProvider>().refreshUser();
      }
    } catch (e) {
      debugPrint("Error en inversión: $e");
      if (context.mounted) {
        CustomLoading.showError(e.toString().replaceAll("Exception: ", ""));
      }
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

      // Traer la transacción activa directamente por usuario y fondo
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
      final double amount = parseDouble(doc.data()['amount'] ?? 0);

      // Transacción atómica
      await _firestore.runTransaction((transaction) async {
        // Actualizar estado de la transacción
        transaction.update(doc.reference, {
          'status': 'cancelled',
          'cancelDate': DateTime.now(),
        });

        // Referencia del usuario
        final userDocRef = _firestore
            .collection('client_model')
            .doc(user.cedula);
        final freshUser = await transaction.get(userDocRef);
        final double currentMoney = parseDouble(
          freshUser.data()?['money'] ?? 0,
        );

        // Sumar monto cancelado al dinero
        transaction.update(userDocRef, {'money': currentMoney + amount});
      });

      // Actualizar sesión / UI
      if (context.mounted) {
        await context.read<SessionProvider>().refreshUser();
      }

      CustomLoading.showSuccess('Inversión cancelada ✅');
    } catch (e) {
      debugPrint("Error al cancelar inversión: $e");
      CustomLoading.showError('Error al cancelar: ${e.toString()}');
    } finally {
      CustomLoading.dismiss();
    }
  }
}
