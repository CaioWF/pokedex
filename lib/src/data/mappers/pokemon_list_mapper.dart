import 'package:pokedex/src/data/models/pokemon_list_model.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';

class PokemonListMapper {
  static PokemonListEntity fromEntity(PokemonListModel entity) {
    return PokemonListEntity(
      number: entity.id,
      name: entity.name,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      types: ['Grass', 'Poison'],
    );
  }
}