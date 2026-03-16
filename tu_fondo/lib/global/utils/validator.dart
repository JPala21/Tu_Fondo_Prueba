class Validator {
  /// Valida que el campo NO esté vacío
  static String? required(String? value, {String message = "Campo requerido"}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Valida un correo electrónico
  static String? email(String? value, {String message = "Correo inválido"}) {
    if (value == null || value.trim().isEmpty) {
      return "Ingrese su correo";
    }
    if (!value.contains("@") || !value.contains(".")) {
      return message;
    }
    return null;
  }

  /// Valida contraseña mínima
  static String? password(
    String? value, {
    int minLength = 3,
    String emptyMessage = "Ingrese su contraseña",
    String lengthMessage = "Mínimo 3 caracteres",
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    if (value.length < minLength) {
      return lengthMessage;
    }
    return null;
  }

  /// Valida que el texto alcance un tamaño mínimo
  static String? minLength(
    String? value,
    int min, {
    String message = "No cumple el mínimo requerido",
  }) {
    if (value == null || value.isEmpty) return message;
    if (value.length < min) return message;
    return null;
  }

  /// Valida que solo contenga números
  static String? numeric(
    String? value, {
    String message = "Solo números permitidos",
  }) {
    if (value == null || value.trim().isEmpty) return message;
    final numReg = RegExp(r'^[0-9]+$');
    if (!numReg.hasMatch(value)) return message;
    return null;
  }

  /// Valida que solo contenga letras
  static String? letters(
    String? value, {
    String message = "Solo letras permitidas",
  }) {
    if (value == null || value.trim().isEmpty) return message;
    final reg = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (!reg.hasMatch(value)) return message;
    return null;
  }

  ///Valida si 2 String son iguales
  static String? equal(String? value, String value2) {
    if (value == null || value.isEmpty) {
      return "Confirme su contraseña";
    }
    if (value != value2) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }
}
