
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00838F); // Dark Cyan
  static const Color secondaryColor = Color(0xFFFF8A65);
  static const Color scaffoldBg = Color(0xFFE0F7FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
