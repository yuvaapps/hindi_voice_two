import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, Royal Indigo & Electric Blue/Violet Palette
  static const Color primaryColor = Color(0xFF3F51B5); // Royal Indigo
  static const Color primaryLight = Color(0xFFE8EAF6); // Soft Pastel Lavender-Indigo
  static const Color secondaryColor = Color(0xFF5C6BC0); // Electric Indigo Slate
  static const Color accentColor = Color(0xFF00E676); // Mint Emerald (Success)
  static const Color scaffoldBg = Color(0xFFF7F8FD); // Gentle Lavender Tint Background
  static const Color textColor = Color(0xFF1A237E); // Deep Midnight Indigo Navy
  static const Color subtitleColor = Color(0xFF3949AB); // Indigo Slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF5C6BC0), Color(0xFF303F9F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFE8EAF6)],
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
