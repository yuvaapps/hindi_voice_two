import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // App 34: Premium Dark Slate Chalkboard & Neon Chalk
  static const Color primaryColor = Color(0xFF263238); // Dark Slate Blue Grey
  static const Color secondaryColor = Color(0xFF37474F); // Chalkboard Border Grey
  static const Color accentColor = Color(0xFFFFD600); // Neon Chalk Yellow
  static const Color scaffoldBg = Color(0xFF1A2327); // Deep Slate Black
  static const Color cardColor = Color(0xFF243036); // Slate Surface
  static const Color textColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardColor,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardColor,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
