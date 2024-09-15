import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/core/repositories/base_repository.dart';
import 'package:pokedex/src/data/mappers/pokemon_list_mapper.dart';
import 'package:pokedex/src/data/models/pokemon_list_model.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends BaseRepository implements PokemonRepository  {
  final String apiBaseUrl;
  final Dio dio;
  CancelToken? cancelToken;

  PokemonRepositoryImpl({required this.apiBaseUrl, required this.dio});

  @override
  Future<Either<Failure, List<PokemonListEntity>?>> fetchPokemonList(int limit, int offset, dynamic generation) async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel('New request dispatched. All previous requests are cancelled.');
    }

    cancelToken = CancelToken();

    return safeFetch(() async {
      final response = await dio.get(
        '$apiBaseUrl/pokemon?limit=$limit&offset=$offset',
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        return (data['results'] as List<dynamic>).map((result) {
          return PokemonListMapper.fromEntity(
            PokemonListModel(
              id: extractIdFromUrl(result['url']),
              name: result['name'],
              url: result['url'],
            ),
            generation
          );
        }).toList();
      } else {
        throw Exception('Failed to load Pokémon list');
      }
    });
  }

  int extractIdFromUrl(String url) {
    final regex = RegExp(r'/(\d+)/$');
    final match = regex.firstMatch(url);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    throw Exception('Invalid URL');
  }
}