import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_short_model.dart';
import 'package:hello_pokemon/app/modules/core/types/async_result.dart';

abstract interface class IPokemonRepository {
  AsyncResult<AppException, List<PokemonShortModel>> getPokemonList({
    int offset = 20,
    int limit = 20,
  });
  AsyncResult<AppException, PokemonDetailModel> getPokemonDetail(
    String pokemonName,
  );
  AsyncResult<AppException, List<PokemonDetailModel>>
  getPokemonListWithDetails({int offset = 20, int limit = 20});
}
