import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

/// Neo-brutalist Material 3 theme: chunky type, black outlines.
abstract final class AppTheme {
  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.ink,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      surfaceTint: Colors.transparent,
    );

    final TextTheme textTheme = _textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: textTheme,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.6,
        ),
        iconTheme: IconThemeData(color: AppColors.ink),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1.4,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(
          color: AppColors.inkTertiary,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.ink, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.ink, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.ink, width: 2.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.surface,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.ink, width: 2),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          backgroundColor: AppColors.surface,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: AppColors.ink, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.ink, width: 2),
        ),
        contentTextStyle: const TextStyle(
          color: AppColors.surface,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static TextTheme _textTheme() {
    return const TextTheme(
      displayMedium: TextStyle(
        color: AppColors.ink,
        fontSize: 38,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.8,
        height: 1.05,
      ),
      displaySmall: TextStyle(
        color: AppColors.ink,
        fontSize: 30,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.2,
        height: 1.1,
      ),
      headlineSmall: TextStyle(
        color: AppColors.ink,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
      ),
      titleLarge: TextStyle(
        color: AppColors.ink,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      titleMedium: TextStyle(
        color: AppColors.ink,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
      bodyLarge: TextStyle(
        color: AppColors.ink,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        color: AppColors.inkSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        color: AppColors.ink,
        fontSize: 14,
        fontWeight: FontWeight.w800,
      ),
      labelSmall: TextStyle(
        color: AppColors.inkSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    );
  }
}
