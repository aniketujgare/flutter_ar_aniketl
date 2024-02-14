import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../device_type.dart';
import '../styles.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double circularRadius;
  final double? fontSize;
  const ReusableButton({
    super.key,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    this.onPressed,
    this.padding,
    this.circularRadius = 18,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 45.h),
      height: 70.h,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(circularRadius))),
            backgroundColor: buttonColor),
        child: Text(
          text,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito100w700white
                  .copyWith(color: textColor, fontSize: fontSize)
              : AppTextStyles.nunito80w700white
                  .copyWith(color: textColor, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
