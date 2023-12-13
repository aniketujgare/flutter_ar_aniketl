import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';
import '../../../data/models/phone_number.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_validation_bloc/login_validation_bloc.dart';

// SmartXR@devteam1
class LoginPage1MobileNumber extends StatelessWidget {
  const LoginPage1MobileNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String mobNo = '';
    return BlocListener<LoginValidationBloc, LoginValidationState>(
      listener: (context, state) {
        // print('validation status ' + state.status.toString());
        if (state.status.isFailure) {
          if (state.phoneNumber.error == PhoneNumberValidationError.digitLess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('The mobile number contains fewer than 10 digits.')));
          }
        } else if (state.phoneNumber.error ==
            PhoneNumberValidationError.digitExcess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The mobile number exceeds 10 digits.')));
        } else if (state.phoneNumber.error ==
            PhoneNumberValidationError.invalid) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Please ensure the phone number entered is valid')));
        }
      },
      child: Column(
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
                : AppTextStyles.nunito100w400white,
          ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<LoginValidationBloc, LoginValidationState>(
            builder: (context, state) {
              return ReusableTextField(
                textInputType: TextInputType.number,
                onChanged: (value) {
                  mobNo = value;
                  print(value);
                  context
                      .read<LoginValidationBloc>()
                      .add(PhoneNumberChanged(phoneNumber: value));
                },
              );
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          ReusableButton(
            buttonColor: AppColors.primaryColor,
            text: 'Send OTP',
            textColor: Colors.white,
            onPressed: () async {
              context
                  .read<LoginValidationBloc>()
                  .add(const PhoneNumberSubmitted());
              final isValid = context.read<LoginValidationBloc>().state.isValid;
              if (isValid) {
                context
                    .read<LoginBloc>()
                    .add(CheckMobileNoExists(mobileNumber: mobNo));
              }
              // print(mobNo);
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
                : AppTextStyles.nunito100w400white,
          ),
          SizedBox(
            height: 16.h,
          ),
          ReusableButton(
            text: 'Guest',
            buttonColor: AppColors.textFieldFillColorWhite,
            textColor: AppColors.primaryColor,
            onPressed: () {
              context.read<LoginBloc>().add(
                  const LoginEvent.updateStatus(status: LoginStatus.guest));
            },
          ),
        ],
      ),
    );
  }
}
