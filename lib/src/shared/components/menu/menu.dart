import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/components/common/icon_button_custom.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class Menu extends StatelessWidget {
  final VoidCallback onGenerationSelected;
  final VoidCallback onOrderSelected;
  final VoidCallback onFilterSelected;

  const Menu({
    super.key,
    required this.onGenerationSelected,
    required this.onOrderSelected,
    required this.onFilterSelected
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButtonCustom(
          assetPath: 'assets/icons/generation.svg',
          onPressed: onGenerationSelected,
          size: 25.0,
          color: AppColors.textBlack, // Usando uma cor do tema
        ),
        const SizedBox(width: 20),
        IconButtonCustom(
          assetPath: 'assets/icons/sort.svg',
          onPressed: onOrderSelected,
          size: 25.0,
          color: AppColors.textBlack, // Usando uma cor do tema
        ),
        const SizedBox(width: 20),
        IconButtonCustom(
          assetPath: 'assets/icons/filter.svg',
          onPressed: onFilterSelected,
          size: 25.0,
          color: AppColors.textBlack, // Usando uma cor do tema
        ),
      ],
    );
  }
}
