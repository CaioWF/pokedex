import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/presenter/home/widgets/pokemon_list_item.dart';
import 'package:pokedex/src/shared/components/common/search_input_custom.dart';
import 'package:pokedex/src/shared/components/menu/menu.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pokemon> pokemons = [
      const Pokemon(
        number: 1,
        name: 'Bulbasaur',
        types: ['Grass', 'Poison'],
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      ),
      const Pokemon(
        number: 4,
        name: 'Charmander',
        types: ['Fire'],
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      ),
    ];
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppGradients.pokeballGradient.createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: SvgPicture.asset(
                  'assets/images/half-pokeball.svg',
                  semanticsLabel: 'Pokeball background',
                  width: MediaQuery.of(context).size.width,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Menu(
                  onGenerationSelected: () => print('Generation selected'),
                  onOrderSelected: () => print('Order selected'),
                  onFilterSelected: () => print('Filter selected'),
                ),
                const SizedBox(height: 35),
                Text(
                  AppLocalizations.of(context)!.homeTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    height: 1.19,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.homeDescription,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textGrey,
                    height: 1.19,
                  ),
                ),
                const SizedBox(height: 25),
                const SearchInputCustom(),
                Expanded(
                  child: ListView.builder(
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      final EdgeInsets margin = index == 0
                        ? const EdgeInsets.only(top: 0)
                        : const EdgeInsets.only(top: 10);

                      return Container(
                        margin: margin,
                        child: PokemonListItem(
                          pokemon: pokemons[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
