import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurpleTheme {
  // Brand Colors
  static const Color primaryPurple = Color(0xFF6A1B9A); // Logo/Titles
  static const Color darkPurple = Color(0xFF4A148C); // Strong elements
  static const Color lightPurple =
      Color(0xFFF48FB1); // Light Pink Accent (Buttons/Details)
  static const Color secondaryPurple = Color(0xFF8E44AD); // Secondary Text

  // Accents
  static const Color pinkMedium = Color(0xFFEC407A);
  static const Color pinkMauve = Color(0xFFD81B60);
  static const Color coral = Color(0xFFFF8A80);
  static const Color orangeOne = Color(0xFFFF7043);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFBEDEF);
  static const Color backgroundBlack =
      Color(0xFF07050A); // Deeper Midnight Purple-Black for premium feel

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9B3FA5), // Medium Purple (Lighter start)
      Color(0xFFC04A9A), // Pink Purple
      Color(0xFFF48FB1), // Light Pink Accent (Lightest end)
    ],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1FFFFFFF), // White 12% (Subtle start)
      Color(0x0DFFFFFF), // White 5% (Very subtle end)
    ],
  );

  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x80ffffff), Color(0x1Fffffff), Color(0x80ffffff)],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: backgroundLight, // The solid #FBEDEF
      fontFamily: GoogleFonts.outfit().fontFamily,
      colorScheme: const ColorScheme.light(
        primary: primaryPurple,
        secondary: lightPurple,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: backgroundBlack, // Dark text on light surface
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: primaryPurple, // Dark Purple for headlines
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: primaryPurple,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: secondaryPurple,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 18,
          color: const Color(0xFF424242), // Dark Grey for reading
          height: 1.5,
        ),
        labelLarge: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryPurple,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: backgroundBlack,
      fontFamily: GoogleFonts.outfit().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: lightPurple,
        surface: primaryPurple, // Using brand color as base for some surfaces
        onPrimary: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 18,
          color: Colors.white.withOpacity(0.9),
          height: 1.5,
        ),
        labelLarge: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
