class TransactionModel {
  final String id;
  final String userId;
  final String fundId;
  final String fundName;
  final int amount;
  final String status; // 'active' or 'cancelled'
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fundId': fundId,
      'fundName': fundName,
      'amount': amount,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      userId: map['userId'] ?? '',
      fundId: map['fundId'] ?? '',
      fundName: map['fundName'] ?? '',
      amount: map['amount'] ?? 0,
      status: map['status'] ?? 'active',
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : DateTime.now(),
    );
  }
}