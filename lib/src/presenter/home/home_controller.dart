import 'package:flutter/material.dart';
import 'package:pokedex/src/core/config/pokemon_types.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/core/services/navigation_service.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/usecases/fetch_pokemon_list_usecase.dart';
import 'package:pokedex/src/shared/utils/order_options.dart';

class HomeController extends ChangeNotifier {
  final FetchPokemonListUsecase _fetchPokemonListUseCase;
  final NavigationService _navigationService;

  HomeController(this._fetchPokemonListUseCase, this._navigationService);

  bool _isLoading = false;
  List<PokemonListEntity> _pokemons = [];
  List<PokemonListEntity> _originalPokemons = [];
  String? _errorMessage;

  String _searchQuery = '';
  OrderOption? _currentOrderOption;
  Set<String> _selectedTypes = {};
  Set<String> _selectedWeaknesses = {};

  bool get isLoading => _isLoading;
  List<PokemonListEntity> get pokemons => _pokemons;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchPokemonList(dynamic selectedGeneration) async {
    setLoading(true);
    _errorMessage = null;
    notifyListeners();

    final result = await _fetchPokemonListUseCase(selectedGeneration);

    result.fold(
      (error) {
        _errorMessage = _getMessageFromFailure(error);
        _pokemons = [];
        _originalPokemons = [];
        setLoading(false);
      },
      (pokemons) {
        _originalPokemons = (pokemons ?? []).toList();
        _applyFilters();
        setLoading(false);
      },
    );
    setLoading(false);
    notifyListeners();
  }

  String _getMessageFromFailure(Failure failure) {
    switch (failure.runtimeType) {
      case const (NetworkFailure):
        return 'Please check your internet connection.';
      case const (ServerFailure):
        return 'Server is unavailable. Please try again later.';
      default:
        return 'Unexpected error occurred. Please try again.';
    }
  }

  void sortPokemons(OrderOption orderOption) {
    _currentOrderOption = orderOption;
    _applyFilters();
  }

  void searchPokemon(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void resetFiltersTypesAndWeaknesses() {
    _selectedTypes = {};
    _selectedWeaknesses = {};
    _applyFilters();
  }

  void applyFiltersTypesAndWeaknesses(
    Set<String> selectedTypes,
    Set<String> selectedWeaknesses
  ) {
    _selectedTypes = selectedTypes;
    _selectedWeaknesses = selectedWeaknesses;
    _applyFilters();
  }

  void _applyFilters() {
    List<PokemonListEntity> filteredPokemons = List.from(_originalPokemons);

    if (_searchQuery.isNotEmpty) {
      filteredPokemons = filteredPokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_currentOrderOption != null) {
      final isAscending = _currentOrderOption!.order == 'asc';
      if (_currentOrderOption!.orderBy == 'number') {
        filteredPokemons.sort((a, b) => _compare(a.number, b.number, isAscending));
      } else {
        filteredPokemons.sort((a, b) => _compare(a.name, b.name, isAscending));
      }
    }

    if (_selectedTypes.isNotEmpty) {
      filteredPokemons = filteredPokemons.where((pokemon) {
        return _selectedTypes.any((type) {
          return pokemon.types.map((pType) => pType.toLowerCase()).contains(type.toLowerCase());
        });
      }).toList();
    }

    if (_selectedWeaknesses.isNotEmpty) {
      filteredPokemons = filteredPokemons.where((pokemon) {
        return _selectedWeaknesses.any((weakness) {
          return pokemon.types.any((type) {
            final weaknesses = PokemonTypes.typeWeaknesses[type.toLowerCase()] ?? [];
            return weaknesses.contains(weakness.toLowerCase());
          });
        });
      }).toList();
    }

    _pokemons = filteredPokemons;
    notifyListeners();
  }

  int _compare<T extends Comparable>(T a, T b, bool isAscending) {
    return isAscending ? a.compareTo(b) : b.compareTo(a);
  }

  void navigateToDetail(PokemonListEntity pokemon) {
    _navigationService.navigateTo('/detail', arguments: pokemon);
  }
}