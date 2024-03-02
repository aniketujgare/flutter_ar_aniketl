import 'package:flutter/material.dart';
import '../../../data/models/guest_name.dart';
import '../../../data/models/phone_number.dart';
import '../bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../../core/util/styles.dart';
import '../bloc/guest_validation_bloc/guest_validation_bloc.dart';

class LoginPage4Guest extends StatefulWidget {
  const LoginPage4Guest({
    super.key,
  });

  @override
  State<LoginPage4Guest> createState() => _LoginPage4GuestState();
}

class _LoginPage4GuestState extends State<LoginPage4Guest> {
  late TextEditingController parentsNameController;
  late TextEditingController mobileNumberController;
  @override
  void initState() {
    super.initState();
    parentsNameController = TextEditingController();
    mobileNumberController = TextEditingController();
  }

  @override
  void dispose() {
    parentsNameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 45.h),
                height: DeviceType().isMobile ? 75.h : 65.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: parentsNameController,
                      onChanged: (value) {
                        parentsNameController.text = value;
                        //no first spaces

                        if (parentsNameController.text.isNotEmpty &&
                            !RegExp(r'^[a-z ]+$')
                                .hasMatch(parentsNameController.text)) {
                          parentsNameController.text =
                              parentsNameController.text.substring(
                                  0, parentsNameController.text.length - 1);

                          // debugPrint(newValue);
                        } else {
                          parentsNameController.text =
                              parentsNameController.text;
                        }
                        context.read<GuestValidationBloc>().add(
                            GuestNameChanged(
                                guestName: parentsNameController.text));
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Enter a parent’s full name',
                        isCollapsed: true,
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
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<GuestValidationBloc, GuestValidationState>(
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
                            debugPrint('matched');
                            mobileNumberController.text = value;
                            context.read<GuestValidationBloc>().add(
                                PhoneNumberChanged(
                                    phoneNumber: mobileNumberController.text));
                          } else {
                            debugPrint('not matched');
                            mobileNumberController.text =
                                value.substring(0, value.length - 1);
                            context.read<GuestValidationBloc>().add(
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
              FocusScope.of(context).unfocus();
              context
                  .read<GuestValidationBloc>()
                  .add(const GuestFormSubmitted());
              final isValid = context.read<GuestValidationBloc>().state.isValid;
              if (isValid) {
                debugPrint('guestLogin Number' + mobileNumberController.text);
                context.read<LoginBloc>().add(LoginEvent.guestLogin(
                    mobileNumber: mobileNumberController.text,
                    parentsName: parentsNameController.text.trim()));
              }
            },
          ),
        ],
      ),
    );
  }
}
