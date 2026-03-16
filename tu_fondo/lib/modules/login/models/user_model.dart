class User {
  final String cedula;
  final String nombre;
  final String apellido;
  final String rol;
  final String? email;
  final String? password;
  final int? money;

  User({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.rol,
    this.email,
    this.password,
    this.money,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      cedula: map['cedula']?.toString() ?? '',
      nombre: map['nombre']?.toString() ?? '',
      apellido: map['apellido']?.toString() ?? '',
      rol: map['rol']?.toString() ?? '',
      email: map['email']?.toString(),
      password: map['password']?.toString(),
      money: map['money']
    );
  }

  String get nombreCompleto => '$nombre $apellido';
}
