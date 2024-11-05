import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/core/config/pokemon_generation_config.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/presenter/home/home_controller.dart';
import 'package:pokedex/src/presenter/home/widgets/filter_list.dart';
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
  Set<String> selectedTypes = {};
  Set<String> selectedWeaknesses = {};

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
            )
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Menu(
                  onGenerationSelected: () => _showGenerationPicker(context),
                  onOrderSelected: () => _showSortSelector(context, controller),
                  onFilterSelected: () => _showFilterSelector(context, controller),
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
                SearchInputCustom(
                  onSearch: _onSearch,
                  onLoadingStart: () {
                    controller.setLoading(true);
                  },
                  onLoadingEnd: () {
                    controller.setLoading(false);
                  },
                ),
                controller.isLoading ?
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/animations/search-animation.gif',
                        width: 128,
                        height: 128,
                      ),
                    ),
                  )
                  : controller.errorMessage != null ?
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

                          return GestureDetector(
                            onTap: () => _onPokemonSelected(pokemon),
                            child: Container(
                              margin: margin,
                              child: PokemonListItem(pokemon: pokemon),
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

  void _showFilterSelector(BuildContext context, HomeController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableBottomSheet(
          title: AppLocalizations.of(context)!.filterTitle,
          description: AppLocalizations.of(context)!.filterDescription,
          content: (scrollController) {
            return FilterList(
              selectedTypes: selectedTypes,
              selectedWeaknesses: selectedWeaknesses,
              onResetFilters: () {
                _onResetFilters(controller);
              },
              onApplyFilters: (selectedTypes, selectedWeaknesses) {
                _onApplyFilters(controller, selectedTypes, selectedWeaknesses);
              },
            );
          },
          maxChildSize: 0.55,
        );
      },
    );
  }

  void _fetchPokemonOnSelectedGeneration() async {
    final homeController = Provider.of<HomeController>(context, listen: false);
    await homeController.fetchPokemonList(PokemonGenerations.generations[selectedGeneration]);
    homeController.sortPokemons(selectedOrder);
  }

  void _filterPokemonOnOrderChange(HomeController controller) {
    controller.sortPokemons(selectedOrder);
  }

  void _onSearch(String query) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.searchPokemon(query);
  }

  void _onResetFilters(HomeController controller) {
    controller.setLoading(true);
    setState(() {
      selectedTypes.clear();
      selectedWeaknesses.clear();
    });
    Timer(const Duration(milliseconds: 300), () {
      controller.resetFiltersTypesAndWeaknesses();
      controller.setLoading(false);
    });
  }

  void _onApplyFilters(HomeController controller, Set<String> selectedTypesFilters, Set<String> selectedWeaknessesFilters) {
    controller.setLoading(true);
    setState(() {
      selectedTypes = selectedTypesFilters;
      selectedWeaknesses = selectedWeaknessesFilters;
    });
    Timer(const Duration(milliseconds: 300), () {
      controller.applyFiltersTypesAndWeaknesses(selectedTypes, selectedWeaknesses);
      controller.setLoading(false);
    });
  }

  void _onPokemonSelected(PokemonListEntity pokemon) {
    print('Pokemon selecionado: ${pokemon.number}');
  }
}
