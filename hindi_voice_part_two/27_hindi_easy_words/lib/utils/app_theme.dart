import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant, elegant Pink Color Palette
  static const Color primaryColor = Color(0xFFE91E63); // Vibrant Pink
  static const Color primaryLight = Color(0xFFFCE4EC); // Soft Blush Pastel Pink
  static const Color secondaryColor = Color(0xFFFF4081); // Neon Rose Pink
  static const Color accentColor = Color(0xFF00E676); // Vibrant Green (success)
  static const Color scaffoldBg = Color(0xFFFFF5F8); // Soft warm pink tint
  static const Color textColor = Color(0xFF362029); // Deep berry charcoal
  static const Color subtitleColor = Color(0xFF7E5B68); // Soft berry slate

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFF06292), Color(0xFFD81B60)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFF0F5), Color(0xFFFCE4EC)],
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
