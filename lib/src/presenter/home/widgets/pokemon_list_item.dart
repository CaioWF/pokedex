import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/domain/entities/pokemon_list_entity.dart';
import 'package:pokedex/src/shared/components/common/badge_custom.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';


class PokemonListItem extends StatelessWidget {
  final PokemonListEntity pokemon;

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
                    '#${pokemon.number.toString().padLeft(3, '0')}',
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
                      .map((type) => BadgeCustom(
                          assetPath: 'assets/icons/${type.toLowerCase()}.svg',
                          text: type,
                          backgroundColor: AppColors.typeConfigurations[type]?['color'] ?? AppColors.typeNormal,
                          textColor: AppColors.textWhite
                        )
                      )
                    .toList(),
                  )
                ],
              )
            ],
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
        Positioned(
          right: 10,
          child: Image.network(
            pokemon.imageUrl,
            width: 130,
            height: 130,
          )
        ),
      ],
    );
  }

}