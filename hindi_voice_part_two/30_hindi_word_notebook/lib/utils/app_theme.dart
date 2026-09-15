
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF57C00); // Warm Notebook Amber
  static const Color primaryLight = Color(0xFFFFF3E0);
  static const Color secondaryColor = Color(0xFF1976D2);
  static const Color notebookBg = Color(0xFFFFFDE7); // Pale notebook yellow
  static const Color lineMargin = Color(0xFFFFCDD2);
  static const Color textColor = Color(0xFF212121);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: notebookBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
