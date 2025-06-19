import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData pushPalTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF212121),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0084FF),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: GoogleFonts.michromaTextTheme().copyWith(
    bodyMedium: GoogleFonts.michroma(color: Colors.white),
    bodySmall: GoogleFonts.michroma(color: Colors.white70),
    titleLarge: GoogleFonts.michroma(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF2196F3),
    secondary: const Color(0xFFFFC107),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2196F3),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white10,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: GoogleFonts.michroma(color: Colors.white38),
  ),
);
