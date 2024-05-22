// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color ujuColor = Color(0xFFFA541B);
  static const Color primaryColor = Color(0xFF121212);
  static const Color bgColor = Color(0xFFF5F5F5);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: TextStyle(
        color: primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    chipTheme: ChipThemeData(backgroundColor: bgColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: primaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: primaryColor,
      ),
      displaySmall: TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: primaryColor),
      headlineLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: primaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        letterSpacing: 0.3,
        color: primaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        color: primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: primaryColor),
      ),
      labelStyle: TextStyle(color: primaryColor, fontFamily: 'Roboto'),
    ),
  );
}
