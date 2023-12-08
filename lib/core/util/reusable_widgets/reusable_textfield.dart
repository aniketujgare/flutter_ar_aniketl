import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../styles.dart';

class ReusableTextField extends StatelessWidget {
  final bool countryCodeVisible;
  final String hintText;
  final TextInputType? textInputType;
  const ReusableTextField({
    super.key,
    this.countryCodeVisible = true,
    this.hintText = '',
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45.h),
      height: 65.h,
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          isCollapsed: true,
          hintStyle: AppTextStyles.nunito100w400hintText,
          prefixIcon: countryCodeVisible
              ? Container(
                  padding: EdgeInsets.fromLTRB(60.w, 0, 0, 0),
                  height: double.maxFinite,
                  width: 60.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '+91 ',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.nunito100w700black,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white,
        ),
        style: AppTextStyles.nunito100w700black,
      ),
    );
  }
}
