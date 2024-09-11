import 'package:flutter/material.dart';
import 'package:pokedex/src/core/errors/failure.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/domain/usecases/fetch_pokemon_list_usecase.dart';

class HomeController extends ChangeNotifier {
  final FetchPokemonListUsecase _fetchPokemonListUseCase;

  HomeController(this._fetchPokemonListUseCase);

  bool _isLoading = false;
  List<PokemonListEntity> _pokemons = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<PokemonListEntity> get pokemons => _pokemons;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _fetchPokemonListUseCase(10000, 0);

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
}