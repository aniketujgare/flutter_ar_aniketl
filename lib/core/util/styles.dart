import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

// import 'package:google_fonts/google_fonts.dart';
class AppColors {
  static Color _createColor(int hexValue) {
    return Color(hexValue);
  }

  static var primaryColor = _createColor(0xFF4F3A9C);
  static var secondaryColor = _createColor(0xFF8C7DF0);
  static var accentColor = _createColor(0XffD1CBF9);
  static var textFieldTextColor = _createColor(0xFF212121);
  static var textFieldFillColorWhite = _createColor(0xFFF4F2FE);
  static var submitGreenColor = _createColor(0xFF45C375);
  static var hintTextColor = _createColor(0xFFBCBCBC);
}

class AppTextStyles {
  static TextStyle _createTextStyle(
      {String fontFamily = "Uniform Rounded",
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black,
      FontStyle? fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }

  /// Nunito
  static var nunito95w400white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 100.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white);
  static var nunito100w700black = _createTextStyle(
    color: AppColors.textFieldTextColor,
    fontSize: 100.sp,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
  );
  static var nunito100w400white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 100.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white);
  static var nunito100w400hintText = _createTextStyle(
    color: AppColors.hintTextColor,
    fontSize: 100.sp,
    fontStyle: FontStyle.italic,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
  );
  static var nunito100w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 100.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  static var nunito80w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 80.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  /// United Rounded

  static var unitedRounded270w700 = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 270.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryColor);
  static var uniformRounded100Bold = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 200.sp,
      fontWeight: FontWeight.w900,
      color: AppColors.primaryColor);
  static var unitedRounded140w700 = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 140.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryColor);
}

class AppStyles {
  static final AppStyles _instance = AppStyles._internal();

  factory AppStyles() {
    return _instance;
  }

  AppStyles._internal();

  // Add more styles if needed
}
