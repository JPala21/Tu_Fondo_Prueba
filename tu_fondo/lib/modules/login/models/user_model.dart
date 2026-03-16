class User {
   String cedula;
   String nombre;
   String apellido;
   String rol;
   String? email;
   String? password;
   int? money;

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
      money: map['money'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cedula": cedula,
      "nombre": nombre,
      "apellido": apellido,
      "rol": rol,
      "email": email,
      "password": password,
      "money": money,
    };
  }

  String get nombreCompleto => '$nombre $apellido';
}
