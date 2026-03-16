import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.label,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
  });

  factory CustomTextField.all({
    required String label,
    required Icon prefixIcon,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType typeInput = TextInputType.text,
  }) => CustomTextField(
    textInputType: typeInput,
    controller: controller,
    obscure: false,
    prefixIcon: prefixIcon,
    label: label,
    validator: validator,
  );

  factory CustomTextField.user(
    TextEditingController controller,
    String? Function(String?)? validator,
  ) => CustomTextField(
    controller: controller,
    obscure: false,
    prefixIcon: const Icon(Icons.email),
    label: "Correo electrónico",
    validator: validator,
  );

  factory CustomTextField.password({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required bool obscure,
    required VoidCallback onToggle,
  }) => CustomTextField(
    controller: controller,
    obscure: obscure,
    prefixIcon: const Icon(Icons.lock_outline),
    suffixIcon: IconButton(
      icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      onPressed: onToggle,
    ),
    label: "Contraseña",
    validator: validator,
  );

  @override
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        fillColor: isDark ? colors.surface.withAlpha(128) : Colors.white,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(color: colors.onSurface.withAlpha(180)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon!.icon, color: colors.primary)
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.onSurface.withAlpha(30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colors.primary,
            width: 2,
          ), 
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.error),
        ),
      ),
      validator: validator,
    );
  }
}
