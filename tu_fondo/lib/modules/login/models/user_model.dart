class Cliente {
  final String cedula;
  final String nombre;
  final String apellido;
  final String rol;
  final String? email;
  final String? password;
  final bool isSMS;

  Cliente({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.rol,
    this.email,
    this.password,
    required this.isSMS,
  });

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      cedula: map['cedula']?.toString() ?? '',
      nombre: map['nombre']?.toString() ?? '',
      apellido: map['apellido']?.toString() ?? '',
      rol: map['rol']?.toString() ?? '',
      email: map['email']?.toString(),
      password: map['password']?.toString(),
      isSMS: map['isSMS'],
    );
  }

  String get nombreCompleto => '$nombre $apellido';
}
