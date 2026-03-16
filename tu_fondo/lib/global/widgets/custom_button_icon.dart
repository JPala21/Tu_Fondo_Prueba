import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';

class CustomButtonIcon extends StatelessWidget {
  final double radius;
  final Widget icon;
  final double iconSize;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CustomButtonIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.radius = 25,
    this.iconSize = 20,
    this.backgroundColor = Colors.green,
  });

  factory CustomButtonIcon.loginOrLogout({
    required BuildContext context,
    double radius = 25,
    double iconSize = 20,
  }) {
    final sessionProvider = context.watch<SessionProvider>();
    final isLogged = sessionProvider.isLogged;

    if (!isLogged) {
      return CustomButtonIcon(
        icon: const Icon(Icons.person, color: Colors.white),
        radius: radius,
        iconSize: iconSize,
        backgroundColor: Colors.red,
        onTap: () {
          context.push('/login');
        },
      );
    } else {
      return CustomButtonIcon(
        icon: const Icon(Icons.person, color: Colors.white),
        radius: radius,
        iconSize: iconSize,
        backgroundColor: Colors.green,
        onTap: () async {
          final selected = await showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(1000, 80, 10, 0),
            items: const [
              PopupMenuItem(value: 'profile', child: Text('Perfil')),
              PopupMenuItem(value: 'logout', child: Text('Cerrar sesión')),
            ],
          );

          if (selected == 'profile') {
            if (!context.mounted) return;
            context.push('/profile');
          } else if (selected == 'logout') {
            await sessionProvider.logout();
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
          }
        },
      );
    }
  }

  factory CustomButtonIcon.logout({
    required BuildContext context,
    required SessionProvider sessionProvider,
    double radius = 25,
    double iconSize = 20,
  }) {
    return CustomButtonIcon(
      icon: const Icon(Icons.logout, color: Colors.white),
      radius: radius,
      iconSize: iconSize,
      backgroundColor: Colors.green,
      onTap: () async {
        context.go('/');
        await sessionProvider.logout();
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: SizedBox(width: iconSize, height: iconSize, child: icon),
      ),
    );
  }
}
