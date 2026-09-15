
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF673AB7);
  static const Color primaryLight = Color(0xFFEDE7F6);
  static const Color secondaryColor = Color(0xFFFF4081);
  static const Color accentColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFF9F7FC);
  static const Color textColor = Color(0xFF212121);
  static const Color subtitleColor = Color(0xFF616161);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF673AB7), Color(0xFF512DA8)],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
    );
  }
}
