import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/selector_mode_provider.dart';

class ButtonModeColor extends StatelessWidget {
  final double width;
  final double height;

  const ButtonModeColor({super.key, this.width = 0.15, this.height = 0.26});

  @override
  Widget build(BuildContext context) {
    final selectorMode = context.watch<SelectorModeProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
      child: IconButton(
        onPressed: selectorMode.selecModeColor,
        icon: selectorMode.statusMode
            ? Icon(color: colorScheme.surface, Icons.sunny_snowing)
            : Icon(color: colorScheme.surface, Icons.nightlight_sharp),
      ),
    );
  }
}
