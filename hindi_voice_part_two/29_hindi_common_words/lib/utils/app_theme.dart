import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, Royal Violet Palette
  static const Color primaryColor = Color(0xFF7C4DFF); // Electric Vivid Violet
  static const Color primaryLight = Color(0xFFEDE7F6); // Soft Pastel Lavender
  static const Color secondaryColor = Color(0xFFB388FF); // Radiant Lavender Accent
  static const Color accentColor = Color(0xFF00E676); // Mint Green (success)
  static const Color scaffoldBg = Color(0xFFFAF8FD); // Very soft warm lavender tint
  static const Color textColor = Color(0xFF261D36); // Deep plum charcoal
  static const Color subtitleColor = Color(0xFF645778); // Soft lavender slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF7C4DFF), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFAF8FD), Color(0xFFEDE7F6)],
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
