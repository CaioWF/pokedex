import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/core/config/pokemon_generation_config.dart';
import 'package:pokedex/src/presenter/home/home_controller.dart';
import 'package:pokedex/src/presenter/home/widgets/generation_grid.dart';
import 'package:pokedex/src/presenter/home/widgets/order_select_list.dart';
import 'package:pokedex/src/presenter/home/widgets/pokemon_list_item.dart';
import 'package:pokedex/src/shared/components/common/bottom_sheet_custom.dart';
import 'package:pokedex/src/shared/components/common/search_input_custom.dart';
import 'package:pokedex/src/shared/components/menu/menu.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';
import 'package:pokedex/src/shared/utils/order_options.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedGeneration = 'firstGeneration';
  OrderOption selectedOrder = orderOptions.first;

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
                  onOrderSelected: () => _showSortSelector(context, controller),
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
          title: AppLocalizations.of(context)!.generationFilterTitle,
          description: AppLocalizations.of(context)!.generationFilterDescription,
          content: (scrollController) {
            return GenerationGrid(
              selectedGeneration: selectedGeneration,
              onItemSelected: (generation) {
                setState(() {
                  selectedGeneration = generation;
                  _fetchPokemonOnSelectedGeneration();
                });
              },
              generations: generations,
              scrollController: scrollController,
            );
          },
          maxChildSize: 0.85,
        );
      },
    );
  }

  void _showSortSelector(BuildContext context, HomeController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableBottomSheet(
          title: AppLocalizations.of(context)!.orderFilterTitle,
          description: AppLocalizations.of(context)!.orderFilterDescription,
          content: (scrollController) {
            return OrderSelectList(
              selectedOrder: selectedOrder,
              onItemSelected: (OrderOption orderOption) {
                setState(() {
                  selectedOrder = orderOption;
                _filterPokemonOnOrderChange(controller);
                });
              },
              orderOptions: orderOptions,
              scrollController: scrollController,
            );
          },
          maxChildSize: 0.55,
        );
      },
    );
  }

  void _fetchPokemonOnSelectedGeneration() {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.fetchPokemonList(PokemonGenerations.generations[selectedGeneration]);
  }

  void _filterPokemonOnOrderChange(HomeController controller) {
    controller.sortPokemons(selectedOrder);
  }
}
