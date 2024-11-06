import 'package:flutter/material.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';

class PokemonDetail extends StatelessWidget {
  final PokemonListEntity pokemon;

  const PokemonDetail({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                pokemon.imageUrl,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Number: #${pokemon.number}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Type(s): ${pokemon.types.join(', ')}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
