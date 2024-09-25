import 'package:pokedex/src/data/models/pokemon_list_model.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/shared/utils/string_util.dart';

class PokemonListMapper {
  static PokemonListEntity fromEntity(PokemonListModel entity, dynamic generation) {
    final name = StringUtil.capitalizeFirst(
      StringUtil.removeByRegex(entity.name, r'-normal')
    );
    final types = generation['pokemonTypes'][entity.name] ?? []; // must use entity.name

    return PokemonListEntity(
      number: entity.id,
      name: name,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${entity.id}.png',
      types: types,
    );
  }
}