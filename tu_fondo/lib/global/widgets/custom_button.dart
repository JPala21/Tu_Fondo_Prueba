import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor; // Ahora son opcionales
  final Color? textColor;
  final Color? borderColor;
  final double height;
  final double width;
  final double fontSize;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.fontSize,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 14,
  });

  // Factory para el botón principal (Lleno)
  factory CustomButton.primary({
    required String text,
    required VoidCallback onPressed,
    double width = double.infinity, // Por defecto ancho completo
    double height = 55,
    double fontSize = 16,
  }) => CustomButton(
    text: text,
    onPressed: onPressed,
    width: width,
    height: height,
    fontSize: fontSize,
    // Dejamos los colores nulos para que el build los tome del Theme
  );

  // Factory para el botón delineado (Secundario)
  factory CustomButton.outlined({
    required String text,
    required VoidCallback onPressed,
    double width = double.infinity,
    double height = 55,
    double fontSize = 16,
  }) => CustomButton(
    text: text,
    onPressed: onPressed,
    width: width,
    height: height,
    fontSize: fontSize,
    backgroundColor: Colors.transparent, // Identificador para el Outlined
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Si backgroundColor es transparente, es un OutlinedButton
    final bool isOutlined = backgroundColor == Colors.transparent;

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                // Usa el color primario para el borde o el que definas
                side: BorderSide(
                  color: borderColor ?? colors.primary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  // Texto del color del borde para consistencia
                  color: textColor ?? colors.primary,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                // Usa el primario del Scheme (Azul Institucional o Azul Vibrante)
                backgroundColor: backgroundColor ?? colors.primary,
                foregroundColor:
                    textColor ?? colors.onPrimary, // Color del splash y texto
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? colors.onPrimary,
                ),
              ),
            ),
    );
  }
}
