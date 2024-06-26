import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppTheme {
  static const Color ujuColor = Color(0xFFFA541B);
  static const Color primaryColor = Color(0xFF121212);
  static const Color cardBg = Color(0xFFF3F3F3);
  static const Color bgColor = Color(0xFFF5F5F5);
  static const Color textPrimaryColor =
      Color(0xFF1a1a1a); // Dark gray for light background
  static const Color textSecondaryColor =
      Color(0xFF666666); // Medium gray for light background

  static final NumberFormat _nf = NumberFormat('#,###');

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
        fontFamily: 'NotoSans',
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
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(fillColor: Colors.white)),
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
        fontFamily: 'NotoSans',
        color: textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSans',
        color: textPrimaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSans',
        color: textPrimaryColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSans',
        color: textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        //default font
        fontSize: 14.0,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textSecondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textPrimaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 11.0,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textSecondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0,
        fontFamily: 'NotoSans',
        letterSpacing: 0.1,
        color: textSecondaryColor,
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
      labelStyle: TextStyle(color: primaryColor, fontFamily: 'NotoSans'),
    ),
  );
}
