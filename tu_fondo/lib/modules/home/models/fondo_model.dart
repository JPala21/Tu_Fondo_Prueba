class FondoModel {
  final String imageUrl;
  final String name;
  final int minMoney;

  FondoModel({
    required this.imageUrl,
    required this.name,
    required this.minMoney,
  });

  factory FondoModel.fromMap(Map<String, dynamic> map) {
    return FondoModel(
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? 'Sin nombre',
      minMoney: map['minMoney'] is int
          ? map['minMoney']
          : int.tryParse(map['minMoney'].toString()) ?? 0,
    );
  }
}
