import 'package:flutter/material.dart';
import 'package:flutter_ar/data/models/app_api.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';
import '../../../domain/repositories/authentication_repository.dart';

class LoginPage1MobileNumber extends StatelessWidget {
  const LoginPage1MobileNumber({
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
          textInputType: TextInputType.number,
        ),
        SizedBox(
          height: 20.h,
        ),
        ReusableButton(
          buttonColor: AppColors.primaryColor,
          text: 'Send OTP',
          textColor: Colors.white,
          onPressed: () async {
            await AuthenticationRepository().checkMobNoExists();
          },
        ),
        SizedBox(
          height: 70.h,
        ),
        Text(
          'or continue as guest ',
          textAlign: TextAlign.center,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito95w400white
              : AppTextStyles.nunito56w400white,
        ),
        SizedBox(
          height: 16.h,
        ),
        ReusableButton(
          text: 'Guest',
          buttonColor: AppColors.textFieldFillColorWhite,
          textColor: AppColors.primaryColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
