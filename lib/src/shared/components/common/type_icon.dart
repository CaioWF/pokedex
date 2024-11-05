import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class TypeIcon extends StatelessWidget {
  final String type;
  final bool isSelected;

  const TypeIcon({
    super.key,
    required this.type,
    required this.isSelected,
  });

  static const Map<String, Color> _typeColors = {
    'fire': AppColors.typeFire,
    'water': AppColors.typeWater,
    'grass': AppColors.typeGrass,
    'electric': AppColors.typeElectric,
    'ice': AppColors.typeIce,
    'flying': AppColors.typeFlying,
    'bug': AppColors.typeBug,
    'rock': AppColors.typeRock,
    'ground': AppColors.typeGround,
    'psychic': AppColors.typePsychic,
    'ghost': AppColors.typeGhost,
    'dark': AppColors.typeDark,
    'steel': AppColors.typeSteel,
    'fairy': AppColors.typeFairy,
    'fighting': AppColors.typeFighting,
    'poison': AppColors.typePoison,
    'dragon': AppColors.typeDragon,
    'normal': AppColors.typeNormal,
  };

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _typeColors[type.toLowerCase()] ?? AppColors.textWhite;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? typeColor : null,
        shape: BoxShape.circle,
        boxShadow: isSelected
          ? [
              BoxShadow(
                color: typeColor.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ]
          : [], 
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/$type.svg',
          width: 25,
          height: 25,
          colorFilter: isSelected
            ? const ColorFilter.mode(AppColors.textWhite, BlendMode.srcIn)
            : ColorFilter.mode(typeColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
