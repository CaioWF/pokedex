import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/theme/gradients.dart';

class GenerationGrid extends StatefulWidget {
  final String selectedGeneration;
  final Function(String) onItemSelected;
  final List<String> generations;
  final ScrollController scrollController;

  const GenerationGrid({
    super.key,
    required this.selectedGeneration,
    required this.onItemSelected,
    required this.generations,
    required this.scrollController,
  });

  @override
  State<GenerationGrid> createState() => _GenerationGridState();
}

class _GenerationGridState extends State<GenerationGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 160 / 129,
      ),
      itemCount: widget.generations.length,
      itemBuilder: (context, index) {
        final generation = widget.generations[index];
        bool isSelected = generation == widget.selectedGeneration;
        final imageAsset = 'assets/images/generations/generation-${index + 1}.png';

        return GestureDetector(
          onTap: () {
            widget.onItemSelected(generation);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? AppColors.backgroundTypePsychic
                  : AppColors.backgroundDefaultInput,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 15,
                  width: 80,
                  height: 35,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return isSelected ?
                        AppGradients.vectorWhiteGradient.createShader(bounds)
                        : AppGradients.vectorGreyGradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: SvgPicture.asset(
                      'assets/images/dot-pattern-6x3.svg',
                    ),
                  )
                ),
                Positioned(
                  top: 70,
                  left: 60,
                  width: 140,
                  height: 140,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return isSelected ? 
                        AppGradients.pokeballWhiteGradient.createShader(bounds)
                        : AppGradients.pokeballGreyGradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: SvgPicture.asset(
                      'assets/images/pokeball.svg',
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        imageAsset,
                        width: 148,

                        height: 64,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppLocalizations.of(context)!.generation(generation),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isSelected ? AppColors.textWhite : AppColors.textGrey,
                          height: 1.19,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}