import 'package:flutter/material.dart';

import '../resource/color_manager.dart';
import '../resource/font_manager.dart';
import '../resource/size_manager.dart';


TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs28,
    fontWeight: FontWeight.w400,
    color: AppColorManager.white,
  ),
  displayMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs16,
    fontWeight: FontWeight.w400,
    color: AppColorManager.white,
  ),
  displaySmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    color: AppColorManager.black,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs20,
    fontWeight: FontWeight.w600,
    color: AppColorManager.textAppColor,
  ),
  headlineMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs16,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  headlineSmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  titleLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs22,
    fontWeight: FontWeight.w600,
    color: AppColorManager.white,
  ),
  bodyLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.normal,
    color: AppColorManager.textAppColor,
  ),
  bodyMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  bodySmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs11,
    fontWeight: FontWeight.w400,
    color: AppColorManager.grey,
  ),
);


//!App Light Theme
ThemeData lightTheme() {
  return ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorManager.background,
    ),
    brightness: Brightness.light,
    primaryColorLight: AppColorManager.navy,
    scaffoldBackgroundColor: AppColorManager.background,
    fontFamily: FontFamilyManager.cairo,
    primaryColor: AppColorManager.navy,
    textTheme: appTextTheme,
    progressIndicatorTheme:
         const ProgressIndicatorThemeData(color: AppColorManager.navy),
    floatingActionButtonTheme:  const FloatingActionButtonThemeData(
        backgroundColor: AppColorManager.navy,
        foregroundColor: AppColorManager.navy),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorManager.white,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide:  BorderSide(
          color: AppColorManager.navy,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide:  BorderSide(
          color: AppColorManager.navy,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        borderSide: BorderSide(color: AppColorManager.greyWithOpacity1),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w16, vertical: AppHeightManager.h1point5),
      hintStyle: TextStyle(
        color: AppColorManager.greyWithOpacity1,
        fontSize: FontSizeManager.fs16,
        fontWeight: FontWeight.normal,
      ),
      floatingLabelStyle:  TextStyle(
        color: AppColorManager.navy,
      ),
      iconColor: AppColorManager.navy,
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColorManager.navy),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        color: AppColorManager.navy,
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
      ),
    ),
    colorScheme:  ColorScheme.light(primary: AppColorManager.navy)
        .copyWith(
            secondary:
                AppColorManager.navy), // Define the default button theme
    buttonTheme:  ButtonThemeData(
      buttonColor: AppColorManager.navy,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
