import 'package:flutter/material.dart';

import '../assets/fonts.gen.dart';
import 'colors.dart';

class AppTheme {
  const AppTheme();

  String get fontFamily {
    return FontFamily.dMSans;
  }

  TextStyle get defaultButtonTextStyle => TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  AppColors get colors => AppColors.light;

  ThemeData get lightTheme {
    return ThemeData(
      fontFamily: fontFamily,
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        secondary: colors.secondary,
        error: colors.error,
        outline: colors.stroke,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: defaultButtonTextStyle,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          textStyle: defaultButtonTextStyle,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.strokeDarker),
          textStyle: defaultButtonTextStyle,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.dMSans,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
          height: 1.4,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: FontFamily.dMSans,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
          height: 1.4,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(colors.primary),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black45,
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.dMSans,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
        contentTextStyle: TextStyle(
          fontFamily: FontFamily.dMSans,
          fontSize: 16,
          color: colors.textSecondary,
          height: 1.4,
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black45,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colors.primary;
          }
          return null;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        visualDensity: VisualDensity.comfortable,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        side: BorderSide(
          color: colors.strokeDarker,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.stroke,
        thickness: 1,
        space: 0,
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: MenuItemButton.styleFrom(
          backgroundColor: Colors.white,
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
          height: 1.6,
        ),
        titleMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: colors.textPrimary,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colors.textPrimary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.textPrimary,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: colors.textSecondary,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colors.textSecondary,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: colors.textSecondary,
          height: 1.4,
        ),
      ),
    );
  }
}
