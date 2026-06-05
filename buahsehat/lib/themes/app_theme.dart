import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// ================= LIGHT THEME =================
  static final light = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    /// PRIMARY COLOR
    primaryColor: Colors.green,

    /// BACKGROUND
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),

    /// COLOR SCHEME
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.green.shade300,
      surface: Colors.white,
    ),

    /// APP BAR
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    /// TEXT THEME
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyMedium: const TextStyle(color: Colors.black),

      titleLarge: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// CARD
    cardColor: Colors.white,

    /// INPUT
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.green, width: 1.5),
      ),

      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),

    /// ELEVATED BUTTON
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,

        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        minimumSize: const Size(double.infinity, 58),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    /// TEXT BUTTON
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.green),
    ),
  );

  /// ================= DARK THEME =================
  static final dark = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    /// PRIMARY COLOR
    primaryColor: Colors.green,

    /// BACKGROUND
    scaffoldBackgroundColor: const Color(0xFF121212),

    /// COLOR SCHEME
    colorScheme: ColorScheme.dark(
      primary: Colors.green,
      secondary: Colors.green.shade300,
      surface: const Color(0xFF1E1E1E),
    ),

    /// APP BAR
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xFF1E1E1E),

      iconTheme: IconThemeData(color: Colors.white),

      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    /// TEXT THEME
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyMedium: const TextStyle(color: Colors.white),

      titleLarge: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// CARD
    cardColor: const Color(0xFF1E1E1E),

    /// INPUT
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.green, width: 1.5),
      ),

      hintStyle: TextStyle(color: Colors.grey.shade400),
    ),

    /// ELEVATED BUTTON
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,

        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        minimumSize: const Size(double.infinity, 58),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    /// TEXT BUTTON
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.green),
    ),
  );
}
