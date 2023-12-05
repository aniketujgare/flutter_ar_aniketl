import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

// import 'package:google_fonts/google_fonts.dart';
class AppColors {
  static Color _createColor(int hexValue) {
    return Color(hexValue);
  }

  static var primaryColor = _createColor(0xFF4F3A9C);
  static var secondaryColor = _createColor(0xFF8C7DF0);
  static var accentColor = _createColor(0xFFF4F2FE);
}

class AppTextStyles {
  static TextStyle _createTextStyle({
    String fontFamily = "Uniform Rounded",
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Nunito
  static var nunito110w400white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 110.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white);
  static var nunito56w400white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 56.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white);

  static var nunito120w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 120.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  static var nunito80w700white = _createTextStyle(
      fontFamily: "Nunito",
      fontSize: 80.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white);

  /// United Rounded
  ///  TextStyle(
  //   color: Color(0xFF4F3A9C),
  //   fontSize: DeviceType().isMobile ? 270.sp : 140.sp,
  //   fontFamily: 'Uniform Rounded',
  //   fontWeight: FontWeight.w700,
  //   height: 0,
  // ),
  static var unitedRounded270w700 = _createTextStyle(
      fontFamily: 'Uniform Rounded',
      fontSize: 270.sp,
      fontWeight: FontWeight.w700,
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
