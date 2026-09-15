
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF6F00); // Amber
  static const Color secondaryColor = Color(0xFF00C853);
  static const Color scaffoldBg = Color(0xFFFFF8E1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
