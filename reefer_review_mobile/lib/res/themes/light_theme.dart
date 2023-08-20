import 'package:flutter/material.dart';

import '../colors.dart';

var lightTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: secondaryGreen,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondaryGreen,
    selectedItemColor: secondaryOrange,
    unselectedItemColor: primaryBackground,
    elevation: 8.0,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme.light(
    onSecondary: secondaryOrange,
    background: primaryBackground,
    secondary: secondaryGreen,
    primary: secondaryGreen,
    tertiary: secondaryBackground,
    outlineVariant: secondaryOrange,
    secondaryContainer: secondaryBackground,
  ),
  scaffoldBackgroundColor: primaryBackground,
  inputDecorationTheme: const InputDecorationTheme(
    errorMaxLines: 4,
    hintStyle: TextStyle(color: secondaryGreen),
    labelStyle: TextStyle(color: Colors.black),
    errorStyle: TextStyle(color: secondaryOrange, fontWeight: FontWeight.bold),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: secondaryOrange,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: secondaryBackground,
      focusColor: secondaryBackground,
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
    ),
  ),
);
