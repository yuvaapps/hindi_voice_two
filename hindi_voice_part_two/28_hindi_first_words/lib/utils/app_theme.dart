
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF4081); // Bright Rose Pink
  static const Color primaryLight = Color(0xFFFCE4EC);
  static const Color secondaryColor = Color(0xFFFF9100); // Orange
  static const Color accentColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFFFF9FA);
  static const Color textColor = Color(0xFF37474F);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFF4081), Color(0xFFFF6E40)],
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
