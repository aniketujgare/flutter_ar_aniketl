import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/styles.dart';
import '../bloc/login_bloc/login_bloc.dart';

/// This is the basic usage of Pinput
/// For more examples check out the demo directory
class OtpBoxesnButton extends StatefulWidget {
  const OtpBoxesnButton({Key? key}) : super(key: key);

  @override
  State<OtpBoxesnButton> createState() => _OtpBoxesnButtonState();
}

class _OtpBoxesnButtonState extends State<OtpBoxesnButton> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Colors.white;
    const borderColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 275.w,
      height: 85.h,
      textStyle: TextStyle(
        fontSize: DeviceType().isMobile ? 22 : 128.sp,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(DeviceType().isMobile ? 80.w : 40.w),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              keyboardType: TextInputType.number,
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              // validator: (value) {
              //   return value == '2222' ? null : 'Pin is incorrect';
              // },
              onClipboardFound: (value) {
                debugPrint('onClipboardFound: $value');
                pinController.setText(value);
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),

              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(
                      DeviceType().isMobile ? 80.w : 40.w),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(
                      DeviceType().isMobile ? 80.w : 40.w),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          if (context.read<LoginBloc>().state.status != LoginStatus.wrongOtp)
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 25.h,
                  horizontal: MediaQuery.of(context).size.width *
                      (DeviceType().isMobile ? 0.2 : 0.3)),
              child: ReusableButton(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                buttonColor: AppColors.submitGreenColor,
                text: 'Submit',
                textColor: Colors.white,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  print('guest verigy otp: ${pinController.text}');
                  if (pinController.length == 6) {
                    context.read<LoginBloc>().add(LoginEvent.verifyOtp(
                        verificationId: '', smsCode: pinController.text));
                  }
                },
              ),
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

                        context.read<LoginBloc>().add(LoginEvent.verifyOtp(
                            verificationId: '', smsCode: pinController.text));
                      },
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
