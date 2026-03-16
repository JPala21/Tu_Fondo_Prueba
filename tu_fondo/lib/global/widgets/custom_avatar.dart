import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  final Widget icon;
  final double iconSize;
  final Color iconColor;

  const CustomAvatar({
    super.key,
    this.radius = 55,
    this.backgroundColor,
    required this.icon,
    this.iconSize = 50,
    this.iconColor = const Color(0xFF0D47A1),
  });

  factory CustomAvatar.logo(double iconSize) => CustomAvatar(
    icon: Image.asset('assets/transferencia-de-dinero.png', fit: BoxFit.cover),
    radius: iconSize + 15,
    iconSize: iconSize + 5,
  );

  factory CustomAvatar.icon(double iconSize, Icon icon) =>
      CustomAvatar(icon: icon, radius: iconSize + 15, iconSize: iconSize + 5);

      factory CustomAvatar.session(double iconSize, Icon icon,Color color) =>
      CustomAvatar(icon: icon, radius: iconSize + 15, iconSize: iconSize + 5,backgroundColor: color,);
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? (isDark? colors.onPrimary: colors.primary),
      child: icon,
    );
  }
}
