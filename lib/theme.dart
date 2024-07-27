import 'package:flutter/material.dart';

const xkcdBlue = Color(0xFF96A8C8);

const xkcdFont = 'XKCDScript';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen).copyWith(
    surface: Colors.white,
    surfaceContainerLow: Colors.white,
  ),
  cardColor: Colors.white,
  useMaterial3: true,
);
