import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF0077B5),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.urbanist(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        displayMedium: GoogleFonts.urbanist(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        displaySmall: GoogleFonts.urbanist(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        headlineLarge: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        headlineMedium: GoogleFonts.urbanist(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        headlineSmall: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        titleLarge: GoogleFonts.urbanist(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        titleMedium: GoogleFonts.urbanist(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        titleSmall: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        bodyLarge: GoogleFonts.urbanist(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        bodyMedium: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        bodySmall: GoogleFonts.urbanist(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF333333),
        ),
        labelLarge: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
        labelMedium: GoogleFonts.urbanist(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0077B5),
        ),
        labelSmall: GoogleFonts.urbanist(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0077B5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.10), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.10), width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF0077B5),
          textStyle: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.9,
            MediaQuery.of(context).size.height * 0.05,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025),
          )
        ),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        error: Color(0xFFB00020),
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        primary: Color(0xFF0077B5),
        secondary: Color(0xFF0077B5),
        surface: Colors.white,
      ),
    );
  }
}