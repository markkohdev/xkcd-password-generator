import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const xkcdBlue = Color(0xFF96A8C8);

const xkcdFont = 'XKCDScript';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen).copyWith(
    // onSurface: Colors.white,
    // onPrimary: Colors.white,
    surface: Colors.white,
    // primary: xkcdBlue,
    // onPrimary: Colors.black,
    // secondary: Color(0xFFC8A896),
    // tertiary: Color.fromARGB(255, 92, 133, 68),
    // surface: Color(0xFF96A8C8),
    surfaceContainerLow: Colors.white,
  ),
  // fontFamily: GoogleFonts.josefinSans().fontFamily,
  // textTheme: GoogleFonts.josefinSansTextTheme(),
  // textTheme: GoogleFonts.redHatDisplayTextTheme(),
  // fontFamily: GoogleFonts.redHatDisplayTextTheme,
  cardColor: Colors.white,
  useMaterial3: true,
);
