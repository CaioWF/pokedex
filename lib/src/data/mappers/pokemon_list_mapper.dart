import 'package:pokedex/src/core/config/pokemon_types.dart';
import 'package:pokedex/src/data/models/pokemon_list_model.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/shared/utils/string_util.dart';

class PokemonListMapper {
  static PokemonListEntity fromEntity(PokemonListModel entity) {
    return PokemonListEntity(
      number: entity.id,
      name: StringUtil.capitalizeFirst(entity.name),
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${entity.id}.png',
      types: PokemonTypes.typesByPokemon[entity.name] ?? [],
    );
  }
}