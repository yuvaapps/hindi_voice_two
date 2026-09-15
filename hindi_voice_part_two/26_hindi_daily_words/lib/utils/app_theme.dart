import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF6F00); // Vibrant Amber / Orange
  static const Color primaryLight = Color(0xFFFFECB3);
  static const Color secondaryColor = Color(0xFF00B0FF); // Sky Blue
  static const Color accentColor = Color(0xFF00E676); // Lime Green
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFFFF8E7); // Warm cream
  static const Color textColor = Color(0xFF263238);
  static const Color subtitleColor = Color(0xFF546E7A);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFF9100), Color(0xFFFF5722)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
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
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: cardBg,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
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
