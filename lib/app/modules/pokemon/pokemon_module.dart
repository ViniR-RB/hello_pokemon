import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/modules/core/core_module.dart';
import 'package:hello_pokemon/app/modules/pokemon/adapters/i_pokemon_repository.dart';
import 'package:hello_pokemon/app/modules/pokemon/application/list_all_pokemon_with_details_service.dart';
import 'package:hello_pokemon/app/modules/pokemon/controller/pokemon_detail_list_controller.dart';
import 'package:hello_pokemon/app/modules/pokemon/domain/usecase/i_list_all_pokemon_with_details.dart';
import 'package:hello_pokemon/app/modules/pokemon/infra/repository/pokemon_repository_impl.dart';
import 'package:hello_pokemon/app/modules/pokemon/pages/pokemon_detail_list_page.dart';
import 'package:hello_pokemon/app/modules/pokemon/pages/pokemon_detail_page.dart';

class PokemonModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IPokemonRepository>(PokemonRepositoryImpl.new);
    i.add<IListAllPokemonWithDetails>(ListAllPokemonWithDetailsService.new);
    i.addLazySingleton(PokemonDetailListController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => PokemonDetailListPage(
        controller: Modular.get<PokemonDetailListController>(),
      ),
    );
    r.child(
      "/detail",
      child: (context) => PokemonDetailPage(
        initialIndex: Modular.args.data['initialIndex'],
        controller: Modular.get<PokemonDetailListController>(),
      ),
    );
  }
}
