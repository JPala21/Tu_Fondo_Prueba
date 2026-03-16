import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String fundId;
  final String fundName;
  final String status; // 'active' or 'cancelled'
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.fundId,
    required this.fundName,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fundId': fundId,
      'fundName': fundName,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime date = DateTime.now();

    if (map['date'] != null) {
      final value = map['date'];
      if (value is Timestamp) {
        date = value.toDate(); // Firebase Timestamp → DateTime
      // ignore: dead_code
      } else if (value is String) {
        date = DateTime.tryParse(value) ?? DateTime.now(); // fallback
      }
    }

    return TransactionModel(
      id: id,
      userId: map['userId'] ?? '',
      fundId: map['fundId'] ?? '',
      fundName: map['fundName'] ?? '',
      status: map['status'] ?? 'active',
      date: date,
    );
  }
}