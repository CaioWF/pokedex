import 'package:flutter/material.dart';
import 'package:pokedex/src/core/config/app_config.dart';
import 'package:pokedex/src/domain/usecases/fetch_pokemon_list_usecase.dart';
import 'package:pokedex/src/presenter/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/src/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/src/presenter/home/home.dart';
import 'package:pokedex/src/shared/theme/theme.dart';

void main() {
  //repositories
  final pokemonRepository = PokemonRepositoryImpl(apiBaseUrl: AppConfig.apiBaseUrl);
  
  //usecases
  final fetchPokemonListUsecase = FetchPokemonListUsecase(pokemonRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(fetchPokemonListUsecase),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
