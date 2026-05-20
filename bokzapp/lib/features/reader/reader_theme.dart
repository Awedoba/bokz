import 'package:flutter/material.dart';

enum ReaderThemeType {
  light,
  dark,
  sepia,
}

class ReaderTheme {
  final ReaderThemeType type;
  final Color backgroundColor;
  final Color textColor;
  final Color accentColor;
  final double brightness;
  final double contrast;

  const ReaderTheme({
    required this.type,
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
    this.brightness = 1.0,
    this.contrast = 1.0,
  });

  static const light = ReaderTheme(
    type: ReaderThemeType.light,
    backgroundColor: Colors.white,
    textColor: Colors.black87,
    accentColor: Colors.green,
  );

  static const dark = ReaderTheme(
    type: ReaderThemeType.dark,
    backgroundColor: Color(0xFF121212),
    textColor: Colors.white70,
    accentColor: Colors.greenAccent,
  );

  static const sepia = ReaderTheme(
    type: ReaderThemeType.sepia,
    backgroundColor: Color(0xFFFBF0D9),
    textColor: Color(0xFF5F4B32),
    accentColor: Color(0xFF704214),
  );
}
