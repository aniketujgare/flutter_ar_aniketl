import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';

class LoginPage3ParentDetails extends StatelessWidget {
  const LoginPage3ParentDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          'Welcome!',
          textAlign: TextAlign.center,
          style: DeviceType().isMobile
              ? AppTextStyles.uniformRounded100Bold.copyWith(fontSize: 220.sp)
              : AppTextStyles.uniformRounded100Bold,
        ),
        SizedBox(height: 20.h),
        Text(
          'Enter your mobile number to login',
          textAlign: TextAlign.center,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito95w400white
              : AppTextStyles.nunito56w400white,
        ),
        SizedBox(
          height: 16.h,
        ),
        const ReusableTextField(
          countryCodeVisible: false,
          hintText: 'Enter a parent’s full name',
        ),
        SizedBox(
          height: 16.h,
        ),
        const ReusableTextField(),
        SizedBox(
          height: 16.h,
        ),
        ReusableButton(
          buttonColor: AppColors.primaryColor,
          text: 'Send OTP',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
