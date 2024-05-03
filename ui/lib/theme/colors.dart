import 'package:flutter/material.dart';

extension ColorExt on ColorScheme {
  bool get isLight => brightness == Brightness.light;
  bool get isDark => brightness == Brightness.dark;
}

class AppColors {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.secondary2,
    required this.secondary3,
    required this.textPrimary,
    required this.textSecondary,
    required this.stroke,
    required this.strokeDarker,
    required this.label,
    required this.bg,
    required this.error,
    required this.success,
    required this.navBarBackground,
    required this.gradient,
  });

  static const light = AppColors(
    primary: Color(0xFF33357F),
    secondary: Color(0xFFF4B11A),
    secondary2: Color(0xFFB8EE73),
    secondary3: Color(0xFFFF8228),
    textPrimary: Color(0xFF263238),
    textSecondary: Color(0xFF575757),
    stroke: Color(0xFFEAEBEB),
    strokeDarker: Color(0xFFD1D2D2),
    label: Color(0xFFA8ADAF),
    bg: Color(0xFFF3F6F8),
    error: Color(0xFFEA4335),
    success: Color(0xFF11CC43),
    navBarBackground: Color(0xFF1D1E40),
    gradient: [Color(0xFF080A64), Color(0xFF5F61AB)],
  );

  final Color primary;
  final Color secondary;
  final Color secondary2;
  final Color secondary3;
  final Color textPrimary;
  final Color textSecondary;
  final Color stroke;
  final Color strokeDarker;
  final Color label;
  final Color bg;
  final Color error;
  final Color success;
  final Color navBarBackground;
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color blue = const Color(0xff2299DD);
  final Color purple = const Color(0xff8385E4);
  // gradient
  final List<Color> gradient;

  // static const primary = Color(0xFF33357F);
  // static const secondary = Color(0xFFF4B11A);
  // static const textPrimary = Color(0xFF263238);
  // static const textSecondary = Color(0xFF575757);
  // static const stroke = Color(0xFFEAEBEB);
  // static const strokeDarker = Color(0xFFD1D2D2);
  // static const label = Color(0xFFA8ADAF);
  // static const bg = Color(0xFFF3F6F8);
  // static const error = Color(0xFFEA4335);
}
