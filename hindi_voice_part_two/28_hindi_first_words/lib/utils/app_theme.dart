import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, Energetic Red Palette
  static const Color primaryColor = Color(0xFFE53935); // Crimson Red
  static const Color primaryLight = Color(0xFFFFEBEE); // Soft Pastel Blush Red
  static const Color secondaryColor = Color(0xFFFF1744); // Radiant Coral Red
  static const Color accentColor = Color(0xFF00E676); // Mint Green (success)
  static const Color scaffoldBg = Color(0xFFFFF8F8); // Very soft warm red tint
  static const Color textColor = Color(0xFF2B1818); // Deep warm espresso red
  static const Color subtitleColor = Color(0xFF6B4D4D); // Warm clay slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFEF5350), Color(0xFFC62828)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFF8F8), Color(0xFFFFEBEE)],
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
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        labelStyle: const TextStyle(color: textColor),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
