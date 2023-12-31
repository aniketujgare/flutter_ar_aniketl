import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/presentation/login/bloc/login_bloc/login_bloc.dart';
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
  late FocusNode otp1Node;
  late FocusNode otp2Node;
  late FocusNode otp3Node;
  late FocusNode otp4Node;
  late FocusNode otp5Node;
  late FocusNode otp6Node;

  String otp1String = '';
  String otp2String = '';
  String otp3String = '';
  String otp4String = '';
  String otp5String = '';
  String otp6String = '';
  @override
  void initState() {
    super.initState();

    otp1Node = FocusNode();
    otp2Node = FocusNode();
    otp3Node = FocusNode();
    otp4Node = FocusNode();
    otp5Node = FocusNode();
    otp6Node = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    otp1Node.dispose();
    otp2Node.dispose();
    otp3Node.dispose();
    otp4Node.dispose();
    otp5Node.dispose();
    otp6Node.dispose();
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              generateOtpBox(otp1Node, 1),
              generateOtpBox(otp2Node, 2),
              generateOtpBox(otp3Node, 3),
              generateOtpBox(otp4Node, 4),
              generateOtpBox(otp5Node, 5),
              generateOtpBox(otp6Node, 6),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        if (context.read<LoginBloc>().state.status != LoginStatus.wrongOtp)
          ReusableButton(
            buttonColor: AppColors.submitGreenColor,
            text: 'Submit',
            textColor: Colors.white,
            onPressed: () {
              FocusScope.of(context).unfocus();

              debugPrint(otp1String +
                  otp2String +
                  otp3String +
                  otp4String +
                  otp5String +
                  otp6String);
              context.read<LoginBloc>().add(LoginEvent.verifyOtp(
                  verificationId: '',
                  smsCode: otp1String +
                      otp2String +
                      otp3String +
                      otp4String +
                      otp5String +
                      otp6String));
            },
          ),
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

                      debugPrint(otp1String +
                          otp2String +
                          otp3String +
                          otp4String +
                          otp5String +
                          otp6String);
                      context.read<LoginBloc>().add(LoginEvent.verifyOtp(
                          verificationId: '',
                          smsCode: otp1String +
                              otp2String +
                              otp3String +
                              otp4String +
                              otp5String +
                              otp6String));
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
            // autofocus: true,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,

            onChanged: (value) {
              switch (nodeIdx) {
                case 1:
                  otp1String = value;
                  break;

                case 2:
                  otp2String = value;
                  break;
                case 3:
                  otp3String = value;
                  break;
                case 4:
                  otp4String = value;
                  break;
                case 5:
                  otp5String = value;
                  break;
                case 6:
                  otp6String = value;
                  break;
              }
              if (value.length == 1 && nodeIdx == 6) {
                FocusScope.of(context).unfocus();
              }
              if (value.length == 1 && nodeIdx != 6) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && nodeIdx != 1) {
                FocusScope.of(context).previousFocus();
              }
            },

            focusNode: focusNode,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
            style: AppTextStyles.nunito100w700black.copyWith(fontSize: 155.sp),
          ),
        ],
      ),
    );
  }
}
