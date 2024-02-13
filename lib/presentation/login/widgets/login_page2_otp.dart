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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the widget is disposed.

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
          'Enter OTP to login',
          textAlign: TextAlign.center,
          style: DeviceType().isMobile
              ? AppTextStyles.nunito95w400white
              : AppTextStyles.nunito100w400white,
        ),
        SizedBox(
          height: 16.h,
        ),
        const OtpBoxesnButton(),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
