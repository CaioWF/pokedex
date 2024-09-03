import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient vectorGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.3),
      Color.fromRGBO(255, 255, 255, 0.0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient pokeballGradient = LinearGradient(
    colors: [
      Color(0xFFF5F5F5),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient vectorGreyGradient = LinearGradient(
    colors: [
      Color(0xFFE5E5E5), // #E5E5E5
      Color.fromRGBO(245, 245, 245, 0.0), // #F5F5F5 .0
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pokeballGreyGradient = LinearGradient(
    colors: [
      Color(0xFFECECEC), // #ECECEC
      Color(0xFFF5F5F5), // #F5F5F5
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient vectorWhiteGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.3), // #FFFFFF .3
      Color.fromRGBO(255, 255, 255, 0.0), // #FFFFFF .0
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pokeballWhiteGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.1), // #FFFFFF .1
      Color.fromRGBO(255, 255, 255, 0.0), // #FFFFFF .0
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pokemonNameGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.3), // #FFFFFF .3
      Color.fromRGBO(255, 255, 255, 0.0), // #FFFFFF .0
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient pokemonCircleGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.0), // #FFFFFF .0
      Color.fromRGBO(255, 255, 255, 0.35), // #FFFFFF .35
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
  );
}
