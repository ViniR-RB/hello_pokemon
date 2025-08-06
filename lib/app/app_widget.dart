import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hello Pokemon',
      theme: ThemeData(colorSchemeSeed: Colors.red),
      routerConfig: Modular.routerConfig,
    );
  }
}
