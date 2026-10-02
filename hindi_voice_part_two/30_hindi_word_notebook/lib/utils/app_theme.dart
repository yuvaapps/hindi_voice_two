import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, Warm Orange Palette
  static const Color primaryColor = Color(0xFFFF6D00); // Deep Tangerine Orange
  static const Color primaryLight = Color(0xFFFFF3E0); // Soft Cream Pastel Orange
  static const Color secondaryColor = Color(0xFFFF9100); // Electric Amber Orange
  static const Color accentColor = Color(0xFF00E676); // Mint Green (success)
  static const Color notebookBg = Color(0xFFFFFBF5); // Warm Soft Cream Parchment
  static const Color lineMargin = Color(0xFFFFAB91); // Soft Peach-Orange Margin Line
  static const Color textColor = Color(0xFF2C1E14); // Deep Roasted Espresso Brown
  static const Color subtitleColor = Color(0xFF755745); // Warm Honey Slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFF9100), Color(0xFFE65100)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFBF5), Color(0xFFFFF3E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: notebookBg,
      ),
      scaffoldBackgroundColor: notebookBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
