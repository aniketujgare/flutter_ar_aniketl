import 'package:flutter/material.dart';
import 'package:flutter_ar/main.dart';
import '../../../domain/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive/hive.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';
import '../../../data/models/phone_number.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_validation_bloc/login_validation_bloc.dart';

// SmartXR@devteam1
class LoginPage1MobileNumber extends StatefulWidget {
  const LoginPage1MobileNumber({
    super.key,
  });

  @override
  State<LoginPage1MobileNumber> createState() => _LoginPage1MobileNumberState();
}

class _LoginPage1MobileNumberState extends State<LoginPage1MobileNumber> {
  late TextEditingController mobileNumberController;
  @override
  void initState() {
    super.initState();
    mobileNumberController = TextEditingController();
  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String mobNo = '';
    return BlocListener<LoginValidationBloc, LoginValidationState>(
      listenWhen: (p, c) => p != c,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Text('! ${state.phoneNumber.error!.text()}'),
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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 45.h),
                height: DeviceType().isMobile ? 75.h : 65.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: mobileNumberController,
                      onChanged: (value) {
                        if (value.length > 10) {
                          mobileNumberController.text = value.substring(0, 10);
                          return;
                        }
                        if (value.isNotEmpty) {
                          if (RegExp(r'^[0-9]+$').hasMatch(value)) {
                            print('matched');
                            mobileNumberController.text = value;
                            context.read<LoginValidationBloc>().add(
                                PhoneNumberChanged(
                                    phoneNumber: mobileNumberController.text));
                          } else {
                            print('not matched');
                            mobileNumberController.text =
                                value.substring(0, value.length - 1);
                            context.read<LoginValidationBloc>().add(
                                PhoneNumberChanged(
                                    phoneNumber: mobileNumberController.text));
                          }
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: Container(
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
                        ),
                        hintStyle: AppTextStyles.nunito100w400hintText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
              /*
              ReusableTextField(
                textInputType: TextInputType.phone,
                onChanged: (value) {
                  mobNo = value;
                  print(value);
                  context
                      .read<LoginValidationBloc>()
                      .add(PhoneNumberChanged(phoneNumber: value));
                },
              );
              */
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
              // var kidsAppBox = await Hive.openBox("kidsApp");
              // var isLoggedIn = kidsAppBox.put('isLoggedIn', false);
              // print('isLoggedIn, $isLoggedIn');

              FocusScope.of(context).unfocus();
              context
                  .read<LoginValidationBloc>()
                  .add(const PhoneNumberSubmitted());
              final isValid = context.read<LoginValidationBloc>().state.isValid;
              if (isValid) {
                // await authenticationRepository.saveDataToHive(mobNo);
                // await AuthenticationRepository().getParentId(mobNo);
                // await AuthenticationRepository().getallstandardsofschool();
                // await AuthenticationRepository().getstudentprofilesnew();

                context.read<LoginBloc>().add(CheckMobileNoExists(
                    mobileNumber: mobileNumberController.text));
              }
              print(mobNo);
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
            onPressed: () async {
              // var kidsAppBox = await Hive.openBox("kidsApp");
              // var isLoggedIn = kidsAppBox.get('isLoggedIn');
              // print('isLoggedIn, $isLoggedIn');

              context.read<LoginBloc>().add(
                  const LoginEvent.updateStatus(status: LoginStatus.guest));
            },
          ),
        ],
      ),
    );
  }
}
