import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/core/config/pokemon_generation_config.dart';
import 'package:pokedex/src/presenter/home/home_controller.dart';
import 'package:pokedex/src/presenter/home/widgets/pokemon_list_item.dart';
import 'package:pokedex/src/shared/components/common/bottom_sheet_custom.dart';
import 'package:pokedex/src/shared/components/common/search_input_custom.dart';
import 'package:pokedex/src/shared/components/menu/menu.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedGeneration = 'firstGeneration';

  final List<String> generations = PokemonGenerations.generations.keys.toList();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).fetchPokemonList(
        PokemonGenerations.generations[generations.first]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

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
                  onGenerationSelected: () => _showGenerationPicker(context),
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
                controller.isLoading ?
                  const Center(
                    child: CircularProgressIndicator(),
                  ) : controller.errorMessage != null ?
                    Center(
                      child: Text(controller.errorMessage!),
                    ) :
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.pokemons.length,
                        itemBuilder: (context, index) {
                          final EdgeInsets margin = index == 0
                            ? const EdgeInsets.only(top: 0)
                            : const EdgeInsets.only(top: 10);
                          final pokemon = controller.pokemons[index];

                          return Container(
                            margin: margin,
                            child: PokemonListItem(pokemon: pokemon),
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

  void _showGenerationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableBottomSheet(
          title: 'Escolha uma Geração',
          content: _buildGridView(),
          maxChildSize: 0.85,
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 160 / 129,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('Imagem ${index + 1} selecionada');
            Navigator.pop(context); // Fecha o BottomSheet ao selecionar
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.backgroundDefaultInput,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 15,
                  width: 80,
                  height: 35,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppGradients.vectorGreyGradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: SvgPicture.asset(
                      'assets/images/dot-pattern-6x3.svg',
                    ),
                  )
                ),
                Positioned(
                  top: 70,
                  left: 60,
                  width: 140,
                  height: 140,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppGradients.pokeballGreyGradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: SvgPicture.asset(
                      'assets/images/pokeball.svg',
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/generation-1.png',
                        width: 148,
                        height: 64,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Generation 1',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textGrey,
                          height: 1.19,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: generations.length,
      itemBuilder: (context, index) {
        return ListTile(
          // leading: imageItems[index],
          title: Text(generations[index]),
          onTap: () {
            (generation) {
              setState(() {
                selectedGeneration = generation;
                _fetchPokemonOnSelectedGeneration(selectedGeneration);
              });
            };
            Navigator.pop(context);
          },
        );
      },
    );
  }


  void _fetchPokemonOnSelectedGeneration(String generation) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.fetchPokemonList(PokemonGenerations.generations[generation]);
  }
}
