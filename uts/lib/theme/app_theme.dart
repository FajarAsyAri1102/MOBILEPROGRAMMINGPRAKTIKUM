import 'package:flutter/material.dart';

/// Tema bergaya bioskop: latar gelap, aksen emas dan merah marun.
class AppColors {
  static const background = Color(0xFF121014);
  static const surface = Color(0xFF1E1A22);
  static const maroon = Color(0xFF8E1B2D);
  static const gold = Color(0xFFE0B04F);
  static const textMuted = Color(0xFF9C97A3);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      secondary: AppColors.maroon,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
