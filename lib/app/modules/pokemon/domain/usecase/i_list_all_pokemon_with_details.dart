import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/types/async_result.dart';

abstract interface class IListAllPokemonWithDetails {
  AsyncResult<AppException, List<PokemonDetailModel>> call({
    int offset = 20,
    int limit = 20,
  });
}
