import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // App 33 Exclusive: Forest Emerald & Golden Chalkboard Notebook
  static const Color primaryColor = Color(0xFF1B5E20); // Deep Forest Emerald
  static const Color secondaryColor = Color(0xFF2E7D32); // Jade Emerald
  static const Color accentColor = Color(0xFFFFB300); // Warm Gold Sunflower
  static const Color scaffoldBg = Color(0xFFF4F9F4); // Soft Scholastic Mint Cream
  static const Color textColor = Color(0xFF1C2B1D); // Deep Forest Charcoal
  static const Color surfaceColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
