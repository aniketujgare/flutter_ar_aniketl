import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/presentation/login/widgets/otp_boxes_n_button.dart';
import '../bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/styles.dart';

class LoginPage2Otp extends StatefulWidget {
  const LoginPage2Otp({
    super.key,
  });

  @override
  State<LoginPage2Otp> createState() => _LoginPage2OtpState();
}

class _LoginPage2OtpState extends State<LoginPage2Otp> {
  late List<FocusNode> otpNodes;
  late List<String> otpStrings;
  @override
  void initState() {
    super.initState();

    otpNodes = List.generate(6, (index) => FocusNode());
    otpStrings = List.filled(6, '');
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the widget is disposed.
    for (var node in otpNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          'Almost there...',
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
        const OtpBoxesnButton(),
        if (context.read<LoginBloc>().state.status == LoginStatus.wrongOtp)
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 25.h,
                horizontal: MediaQuery.of(context).size.width *
                    (DeviceType().isMobile ? 0.2 : 0.3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 150,
                    child: ReusableButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        buttonColor: AppColors.primaryColor,
                        text: 'Resend',
                        textColor: Colors.white,
                        onPressed: () {
                          context
                              .read<LoginBloc>()
                              .add(const LoginEvent.resendOtp());
                        }),
                  ),
                ),
                Expanded(
                  child: ReusableButton(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    buttonColor: AppColors.submitGreenColor,
                    text: 'Submit',
                    textColor: Colors.white,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      String otp = '';
                      for (var digit in otpStrings) {
                        otp += digit;
                      }
                      debugPrint(otp);
                      context.read<LoginBloc>().add(LoginEvent.verifyOtp(
                          verificationId: '', smsCode: otp));
                    },
                  ),
                )
              ],
            ),
          ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Container generateOtpBox(
    FocusNode? focusNode,
    int nodeIdx,
  ) {
    return Container(
      width: 275.w,
      height: 85.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DeviceType().isMobile ? 80.w : 40.w),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              otpStrings[nodeIdx] = value;
              // ServicesBinding.instance.keyboard.addHandler((KeyEvent event) {
              //   if (event is KeyDownEvent) {
              //     print('key doen: ${event.logicalKey}');
              //   }
              //   if (event.logicalKey.keyLabel == 'Backspace') {
              //     if (value.isEmpty) {
              //       FocusScope.of(context).previousFocus();
              //     }
              //   }
              //   return false;
              // });
              if (nodeIdx == 5 && value.isNotEmpty) {
                FocusScope.of(context).unfocus();
              } else if (value.isEmpty && nodeIdx > 0) {
                // If backspace is pressed and the box is not the first one,
                // clear the content of the current box and move to the previous box.
                otpStrings[nodeIdx] = '';
                FocusScope.of(context).previousFocus();
              } else if (value.isNotEmpty && nodeIdx < 5) {
                // If a digit is entered and the box is not the last one,
                // move the focus to the next box.
                FocusScope.of(context).nextFocus();
              }
            },
            onTap: () {
              // Set the focus to the current box when tapped.
              FocusScope.of(context).requestFocus(focusNode);
            },
            focusNode: focusNode,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            style: AppTextStyles.nunito100w700black.copyWith(fontSize: 155.sp),
          ),
        ],
      ),
    );
  }
}
