import 'package:dartz/dartz.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonListEntity>>> fetchPokemonList(int limit, int offset);
}