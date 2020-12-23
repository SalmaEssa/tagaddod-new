import 'package:flutter/material.dart';
import 'colors.dart';

/// TODO: THIS IS JUST AN EXAMPLE THEME. SOME CHANGES MAY APPLY TO MATCH YOUR PROJECT USE CASE

class AppThemes {
  static final englishAppTheme = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    accentColor: AppColors.accent,
    iconTheme: iconTheme,
    scaffoldBackgroundColor: AppColors.white,
    accentIconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    hintColor: Colors.transparent,
    errorColor: AppColors.redError,
    fontFamily: "Poppins",
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 25.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headline2: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headline3: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      subtitle2: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.darkText),
      button: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.darkText),
      bodyText1: TextStyle(fontSize: 14.0, color: AppColors.darkText),
    ),
  );

  static final arabicAppTheme = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primary,
    accentColor: AppColors.accent,
    iconTheme: iconTheme,
    scaffoldBackgroundColor: AppColors.white,
    accentIconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    hintColor: Colors.transparent,
    errorColor: AppColors.redError,
    fontFamily: "Cairo",
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 25.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headline2: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headline3: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.darkText),
      subtitle2: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.darkText),
      button: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.darkText),
      bodyText1: TextStyle(fontSize: 14.0, color: AppColors.darkText),
    ),
  );

  static final iconTheme = IconThemeData(color: AppColors.primary);
}
