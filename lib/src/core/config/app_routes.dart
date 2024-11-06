import 'package:flutter/material.dart';
import 'package:pokedex/src/presenter/home/home.dart';
import 'package:pokedex/src/presenter/detail/detail.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Home());
      case '/detail':
        final pokemon = settings.arguments as PokemonListEntity;
        return MaterialPageRoute(
          builder: (context) => PokemonDetail(pokemon: pokemon),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Home());
    }
  }
}
