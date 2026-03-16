class User {
  final String cedula;
  final String nombre;
  final String apellido;
  final String email;
  final String password;
  final double money; // cambiar a double
  final String rol;

  User({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.password,
    required this.money,
    required this.rol,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      cedula: map['cedula'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      money: double.tryParse(map['money'].toString()) ?? 0.0, // importante
      rol: map['rol'] ?? 'User',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'password': password,
      'money': money,
      'rol': rol,
    };
  }
}
