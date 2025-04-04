import 'package:flutter/material.dart';

class AppColors {
  // Type Colors
  static const Color typeBug = Color(0xFF8CB230);
  static const Color typeDark = Color(0xFF58575F);
  static const Color typeDragon = Color(0xFF0F6AC0);
  static const Color typeElectric = Color(0xFFEED535);
  static const Color typeFairy = Color(0xFFED63C7);
  static const Color typeFighting = Color(0xFFD04164);
  static const Color typeFire = Color(0xFFFD7F24);
  static const Color typeFlying = Color(0xFF748FC9);
  static const Color typeGhost = Color(0xFF556AAE);
  static const Color typeGrass = Color(0xFF62B957);
  static const Color typeGround = Color(0xFFDD7748);
  static const Color typeIce = Color(0xFF61CEC0);
  static const Color typeNormal = Color(0xFF9DA0AA);
  static const Color typePoison = Color(0xFFA552CC);
  static const Color typePsychic = Color(0xFFEA5D60);
  static const Color typeRock = Color(0xFFBAAB82);
  static const Color typeSteel = Color(0xFF417D9A);
  static const Color typeWater = Color(0xFF4A90DA);

  // Background Type Colors
  static const Color backgroundTypeBug = Color(0xFF8BD674);
  static const Color backgroundTypeDark = Color(0xFF6F6E78);
  static const Color backgroundTypeDragon = Color(0xFF7383B9);
  static const Color backgroundTypeElectric = Color(0xFFF2CB55);
  static const Color backgroundTypeFairy = Color(0xFFEBA8C3);
  static const Color backgroundTypeFighting = Color(0xFFEB4971);
  static const Color backgroundTypeFire = Color(0xFFFFA756);
  static const Color backgroundTypeFlying = Color(0xFF83A2E3);
  static const Color backgroundTypeGhost = Color(0xFF8571BE);
  static const Color backgroundTypeGrass = Color(0xFF8BBE8A);
  static const Color backgroundTypeGround = Color(0xFFF78551);
  static const Color backgroundTypeIce = Color(0xFF91D8DF);
  static const Color backgroundTypeNormal = Color(0xFFB5B9C4);
  static const Color backgroundTypePoison = Color(0xFF9F6E97);
  static const Color backgroundTypePsychic = Color(0xFFFF6568);
  static const Color backgroundTypeRock = Color(0xFFD4C294);
  static const Color backgroundTypeSteel = Color(0xFF4C91B2);
  static const Color backgroundTypeWater = Color(0xFF58ABF6);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundDefaultInput = Color(0xFFF2F2F2);
  static const Color backgroundPressedInput = Color(0xFFE2E2E2);
  static const Color backgroundModal = Color.fromRGBO(23, 23, 27, 0.5);

  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF17171B);
  static const Color textGrey = Color(0xFF747476);
  static const Color textNumber = Color.fromRGBO(23, 23, 27, 0.6);

  // Height Colors
  static const Color heightShort = Color(0xFFFFC5E6);
  static const Color heightMedium = Color(0xFFAEBFD7);
  static const Color heightTall = Color(0xFFAAACB8);

  // Weight Colors
  static const Color weightLight = Color(0xFF99CD7C);
  static const Color weightNormal = Color(0xFF57B2DC);
  static const Color weightHeavy = Color(0xFF5A92A5);

  static const Map<String, Map<String, dynamic>> typeConfigurations = {
    'Grass': {
      'color': typeGrass,
      'backgroundColor': backgroundTypeGrass
    },
    'Poison': {
      'color': typePoison,
      'backgroundColor': backgroundTypePoison,
    },
    'Fire': {
      'color': typeFire,
      'backgroundColor': backgroundTypeFire,
    },
    'Water': {
      'color': typeWater,
      'backgroundColor': backgroundTypeWater,
    },
    'Bug': {
      'color': typeBug,
      'backgroundColor': backgroundTypeBug,
    },
    'Normal': {
      'color': typeNormal,
      'backgroundColor': backgroundTypeNormal,
    },
    'Electric': {
      'color': typeElectric,
      'backgroundColor': backgroundTypeElectric,
    },
    'Ground': {
      'color': typeGround,
      'backgroundColor': backgroundTypeGround,
    },
    'Fairy': {
      'color': typeFairy,
      'backgroundColor': backgroundTypeFairy,
    },
    'Fighting': {
      'color': typeFighting,
      'backgroundColor': backgroundTypeFighting,
    },
    'Psychic': {
      'color': typePsychic,
      'backgroundColor': backgroundTypePsychic,
    },
    'Rock': {
      'color': typeRock,
      'backgroundColor': backgroundTypeRock,
    },
    'Steel': {
      'color': typeSteel,
      'backgroundColor': backgroundTypeSteel,
    },
    'Ice': {
      'color': typeIce,
      'backgroundColor': backgroundTypeIce,
    },
    'Ghost': {
      'color': typeGhost,
      'backgroundColor': backgroundTypeGhost,
    },
    'Dragon': {
      'color': typeDragon,
      'backgroundColor': backgroundTypeDragon,
    },
    'Dark': {
      'color': typeDark,
      'backgroundColor': backgroundTypeDark,
    },
    'Flying': {
      'color': typeFlying,
      'backgroundColor': backgroundTypeFlying,
    },
  };
}
