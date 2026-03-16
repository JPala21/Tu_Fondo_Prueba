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

  factory CustomButton.primary({
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
  );

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
    backgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final bool isOutlined = backgroundColor == Colors.transparent;

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
               
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
                  color: textColor ?? colors.primary,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? colors.primary,
                foregroundColor:
                    textColor ?? colors.onPrimary, 
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
