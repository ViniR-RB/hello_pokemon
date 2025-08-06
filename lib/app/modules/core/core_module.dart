import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/modules/core/rest_client/rest_client.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(RestClient.new);
  }
}
