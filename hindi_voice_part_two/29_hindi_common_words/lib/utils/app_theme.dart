
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00897B); // Teal
  static const Color primaryLight = Color(0xFFE0F2F1);
  static const Color secondaryColor = Color(0xFFFFB300);
  static const Color accentColor = Color(0xFF43A047);
  static const Color scaffoldBg = Color(0xFFF4FAF9);
  static const Color textColor = Color(0xFF263238);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF00897B), Color(0xFF004D40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
