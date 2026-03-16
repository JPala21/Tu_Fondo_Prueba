import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextDecoration decoration;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.fontSize = 14,
    this.decoration = TextDecoration.none,
    this.onLongPress,
  });

  factory CustomTextButton.recover(
    final String text,
    final double? fontSize,
    final VoidCallback onPressed,
  ) => CustomTextButton(
    onPressed: onPressed,
    text: text,
    fontSize: fontSize,
    decoration: TextDecoration.underline,
    color: Colors.cyan.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          decoration: decoration,
        ),
      ),
    );
  }
}
