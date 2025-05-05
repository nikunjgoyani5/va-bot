import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.black000000,
    brightness: Brightness.dark,
  ),
  hoverColor: AppColors.transparent,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  focusColor: AppColors.transparent,
  scaffoldBackgroundColor: AppColors.black141414,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.black141414),
  fontFamily: interFonts,
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: AppColors.black000000,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
  ),
  dialogBackgroundColor: AppColors.black141414,
  dialogTheme: const DialogTheme(
    backgroundColor: AppColors.black141414,
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.whiteFFFFFF,
    brightness: Brightness.light,
  ),
  hoverColor: AppColors.transparent,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  focusColor: AppColors.transparent,
  scaffoldBackgroundColor: AppColors.whiteFFFFFF,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.whiteFFFFFF),
  fontFamily: interFonts,
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: AppColors.black000000,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
  ),
  dialogBackgroundColor: AppColors.whiteFFFFFF,
  dialogTheme: const DialogTheme(
    backgroundColor: AppColors.whiteFFFFFF,
  ),
);
