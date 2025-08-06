import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => SplashPage());
  }
}
