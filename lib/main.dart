import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/app_module.dart';
import 'package:hello_pokemon/app/app_widget.dart';
import 'package:hello_pokemon/app/modules/core/configuration/config_enviroment.dart';
import 'package:hello_pokemon/app/pages/error_page.dart';

void main() {
  runZonedGuarded(
    () async {
      ConfigEnviroment.validate();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      };
      runApp(ModularApp(module: AppModule(), child: AppWidget()));
    },
    (error, stack) {
      log("Houve um erro inesperado", error: error, stackTrace: stack);
      runApp(
        ErrorPage(
          errorMessage: error.toString(),
          stack: stack,
          onRestart: () => restartApp(),
        ),
      );
    },
  );
}

void restartApp() {
  WidgetsBinding.instance.reassembleApplication();
  log("Reiniciando o app");
  main();
}
