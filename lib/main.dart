import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/app_module.dart';
import 'package:hello_pokemon/app/app_widget.dart';
import 'package:hello_pokemon/app/modules/core/configuration/config_enviroment.dart';
import 'package:hello_pokemon/app/pages/error_page.dart';

void main() {
  runZonedGuarded(
    () {
      ConfigEnviroment.validate();
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      };
      runApp(ModularApp(module: AppModule(), child: AppWidget()));
    },
    (error, stack) {
      log("Houve um erro inesperado", error: error, stackTrace: stack);
      runApp(ErrorPage(errorMessage: error.toString(), stack: stack));
    },
  );
}
