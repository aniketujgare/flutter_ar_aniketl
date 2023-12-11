import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/login/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';

class LoginPage4Guest extends StatelessWidget {
  const LoginPage4Guest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String parentsName = '';
    String mobileNumber = '';
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
          'Enter your details to sign up as a guest',
          textAlign: TextAlign.center,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito95w400white
              : AppTextStyles.nunito56w400white,
        ),
        SizedBox(
          height: 16.h,
        ),
        ReusableTextField(
          countryCodeVisible: false,
          hintText: 'Enter a parent’s full name',
          onChanged: (value) {
            parentsName = value;
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        ReusableTextField(
          onChanged: (value) {
            mobileNumber = value;
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        ReusableButton(
          buttonColor: AppColors.primaryColor,
          text: 'Send Otp',
          textColor: Colors.white,
          onPressed: () {
            context
                .read<LoginBloc>()
                .add(LoginEvent.guestLogin(mobileNumber: mobileNumber));
          },
        ),
      ],
    );
  }
}
