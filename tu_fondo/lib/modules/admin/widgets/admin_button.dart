import 'package:flutter/material.dart';
import 'package:tu_fondo/config/responsive_builder.dart';

class AdminButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const AdminButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ResponsiveBuilder(
      builder: (context, responsive) => ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? colors.primary,
          foregroundColor: colors.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(0.02),
            vertical: responsive.hp(0.015),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, size: responsive.scale(18)),
        label: Text(text, style: TextStyle(fontSize: responsive.scale(14))),
      ),
    );
  }
}
