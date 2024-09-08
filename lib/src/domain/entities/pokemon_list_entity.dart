class PokemonListEntity {
  final int number;
  final String name;
  final String imageUrl;
  final List<String> types;

  PokemonListEntity({
    required this.number,
    required this.name,
    required this.imageUrl,
    required this.types,
  });
}