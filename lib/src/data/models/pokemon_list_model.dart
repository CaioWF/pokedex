class PokemonListModel {
  final int id;
  final String name;
  final String url;

  PokemonListModel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}