import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  secondaryHeaderColor: const Color(0xFFe9c368),
  disabledColor: const Color(0xFFA0A4A8),
  errorColor: const Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor, secondary: AppColors.secondaryColor),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondaryColor)),
);
