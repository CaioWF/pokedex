import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonCustom extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const IconButtonCustom({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 25.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
