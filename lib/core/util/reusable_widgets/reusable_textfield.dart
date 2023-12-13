import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:size_config/size_config.dart';

import '../styles.dart';

class ReusableTextField extends StatelessWidget {
  final bool countryCodeVisible;
  final String hintText;
  final String? errorText;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  const ReusableTextField({
    super.key,
    this.countryCodeVisible = true,
    this.hintText = '',
    this.textInputType,
    this.onChanged,
    this.errorText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45.h),
      height: DeviceType().isMobile ? 75.h : 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            focusNode: focusNode,
            keyboardType: textInputType,
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              isCollapsed: true,
              hintStyle: AppTextStyles.nunito100w400hintText,
              errorText: errorText,
              prefixIcon: countryCodeVisible
                  ? Container(
                      padding: EdgeInsets.fromLTRB(60.w, 0, 0, 0),
                      // height: double.maxFinite,
                      width: 280.w,
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.only(
                  left: 60.w,
                  top: DeviceType().isMobile ? 15.h : 5.h,
                  bottom: DeviceType().isMobile ? 15.h : 5.h),
              filled: true,
              fillColor: Colors.white,
            ),
            style: AppTextStyles.nunito100w700black,
          ),
        ],
      ),
    );
  }
}
