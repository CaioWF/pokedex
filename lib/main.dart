import 'package:flutter/material.dart';
import 'package:pokedex/src/core/config/app_config.dart';
import 'package:pokedex/src/core/config/app_routes.dart';
import 'package:pokedex/src/core/network/dio_setup.dart';
import 'package:pokedex/src/core/services/navigation_service.dart';
import 'package:pokedex/src/domain/usecases/fetch_pokemon_list_usecase.dart';
import 'package:pokedex/src/presenter/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/src/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/src/presenter/home/home.dart';
import 'package:pokedex/src/shared/theme/theme.dart';

void main() {
  // setup
  final dio = setupDio();
  final navigationService = NavigationService();

  // repositories
  final pokemonRepository = PokemonRepositoryImpl(apiBaseUrl: AppConfig.apiBaseUrl, dio: dio);

  // usecases
  final fetchPokemonListUsecase = FetchPokemonListUsecase(pokemonRepository);

  runApp(
    MultiProvider(
      providers: [
        Provider<NavigationService>.value(value: navigationService),
        ChangeNotifierProvider(
          create: (_) => HomeController(fetchPokemonListUsecase, navigationService),
        ),
      ],
      child: App(navigationService: navigationService),
    ),
  );
}

class App extends StatelessWidget {
  final NavigationService navigationService;

  const App({super.key, required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      navigatorKey: navigationService.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const Home(),
    );
  }
}
