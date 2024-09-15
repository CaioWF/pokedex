import 'package:dartz/dartz.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/repositories/pokemon_repository.dart';

class FetchPokemonListUsecase {
  final PokemonRepository repository;

  FetchPokemonListUsecase(this.repository);

  Future<Either<Failure, List<PokemonListEntity>?>> call(dynamic selectedGeneration) async {
    final limit = selectedGeneration['pagination']['limit'];
    final offset = selectedGeneration['pagination']['offset'];
    
    return repository.fetchPokemonList(limit, offset, selectedGeneration);
  }
}