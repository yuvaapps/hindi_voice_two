import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, Oceanic Cyan & Deep Teal Palette
  static const Color primaryColor = Color(0xFF0096C7); // Vivid Sea Teal
  static const Color primaryLight = Color(0xFFE0F7FA); // Soft Pastel Ice Cyan
  static const Color secondaryColor = Color(0xFF00B4D8); // Electric Sky Cyan
  static const Color accentColor = Color(0xFF00E676); // Mint Green (success)
  static const Color scaffoldBg = Color(0xFFF2FBFD); // Gentle oceanic cream
  static const Color textColor = Color(0xFF003049); // Deep Abyssal Navy
  static const Color subtitleColor = Color(0xFF0077B6); // Oceanic Teal Slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF00B4D8), Color(0xFF0077B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFE0F7FA)],
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
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: primaryLight,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor);
          }
          return IconThemeData(color: Colors.grey.shade600);
        }),
      ),
    );
  }
}
