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
  static var parentZoneScaffoldColor = _createColor(0xFFF4F2FE);
  static var redMessageSharedFileContainerColor = _createColor(0xFFFF8371);
  static var messageContainerColor = _createColor(0xFFE9E9E9);
  static var subjectNameColor = _createColor(0xFF4D4D4D);
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
  static var nunito85w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 85.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);
  static var nunito80w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 80.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);
  static var nunito115w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 115.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);
  static var nunito62w400TextItalic = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 62.sp,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
      color: AppColors.textFieldTextColor);
  static var nunito88w400Text = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 88.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textFieldTextColor);

  static var nunito85w400Text = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 88.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textFieldTextColor);
  static var nunito75w400Text = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 75.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4D4D4D));
  static var nunito75w700TextWhite = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 75.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  static var nunito88w700Text = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 88.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.textFieldTextColor);
  static var nunito105w700Text = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 105.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.textFieldTextColor);

  /// Uniform Rounded
  static var unitedRounded95w700 = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 95.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.subjectNameColor);
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
  static var uniformRounded136BoldAppBarStyle = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 136.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryColor);
  static var uniformRounded205BoldAppBarStyle = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 205.sp,
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
