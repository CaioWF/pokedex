import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';

class Pokemon {
  final int number;
  final String name;
  final String imageUrl;
  final List<String> types;

  const Pokemon({
    required this.number,
    required this.name,
    required this.imageUrl,
    required this.types,
  });
}
class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.all(20),
          height: 115,
          decoration: BoxDecoration(
            color: AppColors.typeConfigurations[pokemon.types[0]]?['backgroundColor'] ?? AppColors.typeNormal,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${pokemon.number}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textNumber,
                      height: 1.19,
                    ),
                  ),
                  Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textWhite,
                      height: 1.19,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: pokemon.types
                      .map((type) => Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.typeConfigurations[type]?['color'] ?? AppColors.typeNormal,
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/${type.toLowerCase()}.svg',
                              width: 15,
                              height: 15,
                              colorFilter: const ColorFilter.mode(AppColors.textWhite, BlendMode.srcIn)
                            ),
                            const SizedBox(width: 5),
                            Text(
                              type,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.textWhite,
                                height: 1.19,
                              )
                            ),
                          ],
                        ),
                      ))
                    .toList(),
                  )
                ],
              )
            ],
          )
        ),
        Positioned(
          top: -20,
          right: -20,
          child: Image.network(
            pokemon.imageUrl,
            width: 80,
            height: 80,
          )
        ),
        Positioned(
          top: 30,
          left: 90,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppGradients.vectorGradient.createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: SvgPicture.asset(
              'assets/images/dot-pattern-6x3.svg',
              width: 74,
            ),
          )
        ),
        Positioned(
          top: 10,
          right: -15,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppGradients.vectorGradient.createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: SvgPicture.asset(
              'assets/images/pokeball.svg',
              width: 145,
            ),
          )
        ),
      ],
    );
  }

}