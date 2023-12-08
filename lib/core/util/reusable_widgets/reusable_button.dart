import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../device_type.dart';
import '../styles.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;
  const ReusableButton({
    super.key,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45.h),
      height: 70.h,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            backgroundColor: buttonColor),
        child: Text(
          text,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito100w700white.copyWith(color: textColor)
              : AppTextStyles.nunito80w700white.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
