import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/routes.dart';
import 'package:tu_fondo/config/selector_mode_provider.dart';
import 'package:tu_fondo/config/theme_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectorModeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final selectorMode = context.watch<SelectorModeProvider>();

    return MaterialApp.router(
      locale: const Locale('es', ''),
      title: 'Investment App',
      themeMode: selectorMode.themeMode,
      theme: ThemeData(useMaterial3: true, colorScheme: modeLight()),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: modeDark()),
      routerConfig: router,
    );
  }
}
