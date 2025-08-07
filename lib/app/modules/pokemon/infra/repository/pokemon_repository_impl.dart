import 'package:dio/dio.dart';
import 'package:hello_pokemon/app/modules/core/either/either.dart';
import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_short_model.dart';
import 'package:hello_pokemon/app/modules/core/rest_client/rest_client.dart';
import 'package:hello_pokemon/app/modules/core/types/async_result.dart';
import 'package:hello_pokemon/app/modules/pokemon/adapters/i_pokemon_repository.dart';
import 'package:hello_pokemon/app/modules/pokemon/exceptions/pokemon_repository_exception.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  final RestClient _restClient;

  PokemonRepositoryImpl({required RestClient restClient})
    : _restClient = restClient;

  @override
  AsyncResult<AppException, PokemonDetailModel> getPokemonDetail(
    String pokemonName,
  ) async {
    try {
      final Response(:dynamic data) = await _restClient.get(
        "/pokemon/$pokemonName",
      );
      final pokemonDetail = PokemonDetailModel.fromMap(data);
      return Success(pokemonDetail);
    } on DioException {
      return Failure(PokemonRepositoryException());
    }
  }

  @override
  AsyncResult<AppException, List<PokemonDetailModel>>
  getPokemonListWithDetails({int offset = 20, int limit = 20}) async {
    try {
      final Response(:dynamic data) = await _restClient.get(
        "/pokemon?offset=$offset&limit=$limit",
      );

      final pokemonShortList = (data["results"] as List<dynamic>)
          .map((data) => PokemonShortModel.fromMap(data))
          .toList();

      final detailFutures = pokemonShortList
          .map((pokemon) => getPokemonDetail(pokemon.name))
          .toList();

      final detailResults = await Future.wait(detailFutures);

      final List<PokemonDetailModel> pokemonDetailList = [];

      for (final result in detailResults) {
        result.when(
          onSuccess: (detail) {
            pokemonDetailList.add(detail);
          },
          onFailure: (error) {},
        );
      }

      return Success(pokemonDetailList);
    } on DioException {
      return Failure(PokemonRepositoryException());
    }
  }

  @override
  AsyncResult<AppException, List<PokemonShortModel>> getPokemonList({
    int offset = 20,
    int limit = 20,
  }) async {
    try {
      final Response(:dynamic data) = await _restClient.get(
        "/pokemon?offset=$offset&limit=$limit",
      );
      final pokemonShortList = (data["results"] as List<dynamic>)
          .map((data) => PokemonShortModel.fromMap(data))
          .toList();

      return Success(pokemonShortList);
    } on DioException {
      return Failure(PokemonRepositoryException());
    }
  }
}
