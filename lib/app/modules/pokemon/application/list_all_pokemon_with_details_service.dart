import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/types/async_result.dart';
import 'package:hello_pokemon/app/modules/pokemon/adapters/i_pokemon_repository.dart';
import 'package:hello_pokemon/app/modules/pokemon/domain/usecase/i_list_all_pokemon_with_details.dart';

class ListAllPokemonWithDetailsService implements IListAllPokemonWithDetails {
  final IPokemonRepository _pokemonRepository;

  ListAllPokemonWithDetailsService({
    required IPokemonRepository pokemonRepository,
  }) : _pokemonRepository = pokemonRepository;

  @override
  AsyncResult<AppException, List<PokemonDetailModel>> call({
    int offset = 20,
    int limit = 20,
  }) {
    return _pokemonRepository.getPokemonListWithDetails(
      offset: offset,
      limit: limit,
    );
  }
}
