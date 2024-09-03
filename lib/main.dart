import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/components/menu/menu.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';
import 'package:pokedex/src/shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  'assets/images/pokeball.svg',
                  semanticsLabel: 'Pokeball background',
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Menu(
                    onGenerationSelected: () => print('Generation selected'),
                    onOrderSelected: () => print('Order selected'),
                    onFilterSelected: () => print('Filter selected'),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
