import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/selector_mode_provider.dart';

class ButtonModeColor extends StatelessWidget {
  const ButtonModeColor({super.key});

  @override
  Widget build(BuildContext context) {
    final selectorMode = context.watch<SelectorModeProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.onSurface, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        onPressed: selectorMode.selecModeColor,
        icon: selectorMode.statusMode
            ? Icon(color: Colors.white, Icons.sunny_snowing)
            : Icon(color: Colors.black, Icons.nightlight_sharp),
      ),
    );
  }
}
