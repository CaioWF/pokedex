import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class BadgeCustom extends StatelessWidget {
  final String assetPath;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const BadgeCustom({
    super.key,
    required this.assetPath,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(3)
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            assetPath,
            width: 15,
            height: 15,
            colorFilter: const ColorFilter.mode(AppColors.textWhite, BlendMode.srcIn)
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: textColor,
              height: 1.19,
            )
          ),
        ],
      ),
    );
  }
}
