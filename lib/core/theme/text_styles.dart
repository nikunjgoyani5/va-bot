import 'package:va_bot_admin/core/constant/app_constant.dart';
import 'package:va_bot_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle bold(
    double fontSize, {
    Color? fontColor = AppColors.black141414,
    TextOverflow? textOverflow,
    String? fontFamily,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily ?? interFonts,
      fontWeight: fontWeight ?? FontWeight.bold,
      overflow: textOverflow,
      decoration: textDecoration,
    );
  }

  static TextStyle semiBold(
    double fontSize, {
    Color? fontColor = AppColors.black141414,
    TextOverflow? textOverflow,
    String? fontFamily,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily ?? interFonts,
      fontWeight: fontWeight ?? FontWeight.w600,
      overflow: textOverflow,
      decoration: textDecoration,
    );
  }

  static TextStyle medium(
    double fontSize, {
    Color? fontColor = AppColors.black141414,
    TextOverflow? textOverflow,
    String? fontFamily,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily ?? interFonts,
      fontWeight: fontWeight ?? FontWeight.w500,
      overflow: textOverflow,
      decoration: textDecoration,
    );
  }

  static TextStyle regular(
    double fontSize, {
    Color? fontColor = AppColors.black141414,
    TextOverflow? textOverflow,
    String? fontFamily,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? letterSpacing,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily ?? interFonts,
      fontWeight: fontWeight ?? FontWeight.w400,
      overflow: textOverflow,
      decoration: textDecoration,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle light(
    double fontSize, {
    Color? fontColor = AppColors.black141414,
    TextOverflow? textOverflow,
    String? fontFamily,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily ?? interFonts,
      fontWeight: fontWeight ?? FontWeight.w300,
      overflow: textOverflow,
      decoration: textDecoration,
    );
  }
}
