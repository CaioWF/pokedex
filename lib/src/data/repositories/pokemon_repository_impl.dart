import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/core/repositories/base_repository.dart';
import 'package:pokedex/src/data/mappers/pokemon_list_mapper.dart';
import 'package:pokedex/src/data/models/pokemon_list_model.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends BaseRepository implements PokemonRepository  {
  final String apiBaseUrl;

  PokemonRepositoryImpl({required this.apiBaseUrl});

  @override
  Future<Either<Failure, List<PokemonListEntity>>> fetchPokemonList(int limit, int offset) async {
    return safeFetch(() async {
      final response = await http.get(Uri.parse('$apiBaseUrl/pokemon?limit=$limit&offset=$offset'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['results'] as List;

        return results.map((result) {
          return PokemonListMapper.fromEntity(
            PokemonListModel(
              id: extractIdFromUrl(result['url']),
              name: result['name'],
              url: result['url'],
            )
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