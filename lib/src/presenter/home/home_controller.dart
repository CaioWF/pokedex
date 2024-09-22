import 'package:flutter/material.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/usecases/fetch_pokemon_list_usecase.dart';
import 'package:pokedex/src/shared/utils/order_options.dart';

class HomeController extends ChangeNotifier {
  final FetchPokemonListUsecase _fetchPokemonListUseCase;

  HomeController(this._fetchPokemonListUseCase);

  bool _isLoading = false;
  List<PokemonListEntity> _pokemons = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<PokemonListEntity> get pokemons => _pokemons;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonList(dynamic selectedGeneration) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _fetchPokemonListUseCase(selectedGeneration);

    result.fold(
      (error) {
        _errorMessage = _getMessageFromFailure(error);
        _pokemons = [];
        _isLoading = false;
      },
      (pokemons) {
        _pokemons = (pokemons ?? []).toList();
        _isLoading = false;
      },
    );
    _isLoading = false;
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
    final isAscending = orderOption.order == 'asc';
    
    if (orderOption.orderBy == 'number') {
      _pokemons.sort((a, b) => _compare(a.number, b.number, isAscending));
    } else {
      _pokemons.sort((a, b) => _compare(a.name, b.name, isAscending));
    }

    notifyListeners();
  }

  int _compare<T extends Comparable>(T a, T b, bool isAscending) {
    return isAscending ? a.compareTo(b) : b.compareTo(a);
  }
}