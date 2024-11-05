class PokemonTypes {
  static const String bug = 'bug';
  static const String dark = 'dark';
  static const String dragon = 'dragon';
  static const String electric = 'electric';
  static const String fairy = 'fairy';
  static const String fighting = 'fighting';
  static const String fire = 'fire';
  static const String flying = 'flying';
  static const String ghost = 'ghost';
  static const String grass = 'grass';
  static const String ground = 'ground';
  static const String ice = 'ice';
  static const String normal = 'normal';
  static const String poison = 'poison';
  static const String psychic = 'psychic';
  static const String rock = 'rock';
  static const String steel = 'steel';
  static const String water = 'water';

  static const List<String> all = [
    bug,
    dark,
    dragon,
    electric,
    fairy,
    fighting,
    fire,
    flying,
    ghost,
    grass,
    ground,
    ice,
    normal,
    poison,
    psychic,
    rock,
    steel,
    water,
  ];

  static const Map<String, List<String>> typeWeaknesses = {
    'normal': ['fighting'],
    'fire': ['water', 'rock', 'ground'],
    'water': ['electric', 'grass'],
    'electric': ['ground'],
    'grass': ['fire', 'ice', 'poison', 'flying', 'bug'],
    'ice': ['fire', 'fighting', 'rock', 'steel'],
    'fighting': ['flying', 'psychic', 'fairy'],
    'poison': ['ground', 'psychic'],
    'ground': ['water', 'grass', 'ice'],
    'flying': ['electric', 'ice', 'rock'],
    'psychic': ['bug', 'ghost', 'dark'],
    'bug': ['fire', 'flying', 'rock'],
    'rock': ['water', 'grass', 'fighting', 'ground', 'steel'],
    'ghost': ['ghost', 'dark'],
    'dragon': ['ice', 'dragon', 'fairy'],
    'dark': ['fighting', 'bug', 'fairy'],
    'steel': ['fire', 'fighting', 'ground'],
    'fairy': ['poison', 'steel'],
  };
}