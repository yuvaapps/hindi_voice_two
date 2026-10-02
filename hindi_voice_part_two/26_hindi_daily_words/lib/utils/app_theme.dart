import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Radiant Sunny Yellow Palette
  static const Color primaryColor = Color(0xFFF59E0B); // Vibrant Sun Gold / Amber Yellow
  static const Color primaryLight = Color(0xFFFFF9C4); // Cream Pastel Yellow
  static const Color secondaryColor = Color(0xFFFBBF24); // Radiant Sunshine Yellow
  static const Color accentColor = Color(0xFF00E676); // Mint Green (for completions & successes)
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFFFFDE7); // Warm light sunshine yellow background
  static const Color textColor = Color(0xFF3E2723); // Deep warm espresso charcoal for high contrast
  static const Color subtitleColor = Color(0xFF795548); // Warm honey slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFD97706)], // Warm sunburst golden yellow gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
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
        surface: scaffoldBg,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: cardBg,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
