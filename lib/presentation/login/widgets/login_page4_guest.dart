import 'package:flutter/material.dart';
import 'package:flutter_ar/data/models/guest_name.dart';
import 'package:flutter_ar/data/models/phone_number.dart';
import 'package:flutter_ar/presentation/login/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';
import '../bloc/guest_validation_bloc/guest_validation_bloc.dart';

class LoginPage4Guest extends StatelessWidget {
  const LoginPage4Guest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String parentsName = '';
    String mobileNumber = '';
    return BlocListener<GuestValidationBloc, GuestValidationState>(
      listenWhen: (p, c) => p != c,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.guestName.error != null)
                    Text('! ${state.guestName.error!.text()}'),
                  if (state.phoneNumber.error != null)
                    Text('! ${state.phoneNumber.error!.text()}'),
                ],
              ),
            ),
          );
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
            'Enter your details to sign up as a guest',
            textAlign: TextAlign.center,
            style: DeviceType().isMobile
                ? AppTextStyles.nunito95w400white
                : AppTextStyles.nunito100w400white,
          ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<GuestValidationBloc, GuestValidationState>(
            builder: (context, state) {
              return ReusableTextField(
                countryCodeVisible: false,
                hintText: 'Enter a parent’s full name',
                onChanged: (value) {
                  parentsName = value;
                  context
                      .read<GuestValidationBloc>()
                      .add(GuestNameChanged(guestName: value));
                },
              );
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<GuestValidationBloc, GuestValidationState>(
            builder: (context, state) {
              return ReusableTextField(
                onChanged: (value) {
                  mobileNumber = value;
                  context
                      .read<GuestValidationBloc>()
                      .add(PhoneNumberChanged(phoneNumber: value));
                },
                textInputType: TextInputType.number,
              );
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
                  .read<GuestValidationBloc>()
                  .add(const GuestFormSubmitted());
              final isValid = context.read<GuestValidationBloc>().state.isValid;
              if (isValid) {
                context.read<LoginBloc>().add(LoginEvent.guestLogin(
                    mobileNumber: mobileNumber, parentsName: parentsName));
              }
            },
          ),
        ],
      ),
    );
  }
}
