import 'package:flutter/material.dart';

import '../colors.dart';

var lightTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondaryGreen,
    selectedItemColor: secondaryOrange, // A contrast to the background
    unselectedItemColor: primaryBackground, // Adjust this if needed
    elevation: 8.0, // Optional: For a little shadow
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels:
        true, // If you want to show labels for unselected items
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme.light(
      background: primaryBackground,
      secondary: secondaryGreen,
      primary: secondaryGreen),
  scaffoldBackgroundColor: primaryBackground,
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: secondaryGreen),
    labelStyle: TextStyle(color: secondaryGreen),
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
);
