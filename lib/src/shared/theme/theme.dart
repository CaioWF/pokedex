import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'SFProDisplay',
  scaffoldBackgroundColor: AppColors.backgroundWhite,
  textTheme: AppTypography.textTheme,
);