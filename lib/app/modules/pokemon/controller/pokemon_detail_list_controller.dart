import 'package:flutter/cupertino.dart';
import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/helpers/messages.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/pokemon/domain/usecase/i_list_all_pokemon_with_details.dart';

class PokemonDetailListController extends ChangeNotifier
    with MessageControllerMixin {
  final IListAllPokemonWithDetails _listAllPokemonWithDetails;

  final List<PokemonDetailModel> pokemons = [];
  int offset = 0;
  final int limit = 20;
  bool isLoading = false;
  bool hasMore = true;

  PokemonDetailListController({
    required IListAllPokemonWithDetails listAllPokemonWithDetails,
  }) : _listAllPokemonWithDetails = listAllPokemonWithDetails;

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    final result = await _listAllPokemonWithDetails.call(
      offset: offset,
      limit: limit,
    );

    result.when(
      onSuccess: (List<PokemonDetailModel> newList) {
        pokemons.addAll(newList);
        offset += limit;
        isLoading = false;
        hasMore = newList.length == limit;
      },
      onFailure: (AppException error) {
        isLoading = false;
        showError(error.message);
      },
    );
    notifyListeners();
  }

  Future<void> refresh() async {
    offset = 0;
    pokemons.clear();
    hasMore = true;
    await loadMore();
  }
}
