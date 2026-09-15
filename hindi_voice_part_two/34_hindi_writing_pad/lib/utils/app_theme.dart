
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF37474F); // Chalkboard Slate Dark
  static const Color accentColor = Color(0xFFFFEB3B); // Yellow Chalk
  static const Color scaffoldBg = Color(0xFF263238);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(primary: primaryColor, secondary: accentColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(ThemeData.dark().textTheme),
    );
  }
}
