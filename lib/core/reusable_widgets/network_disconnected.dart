import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:size_config/size_config.dart';

import '../util/styles.dart';

class NetworkDisconnected extends StatelessWidget {
  const NetworkDisconnected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.verticalSpacer,
            SizedBox(
                // height: 100.h,
                width: 60.wp,
                child: Lottie.asset('assets/Wifi.json')),
            5.verticalSpacer,
            Text(
              'Checking Connection...',
              style: AppTextStyles.nunito100w700black
                  .copyWith(color: AppColors.primaryColor, fontSize: 120.sp),
            ),
          ],
        ),
      ),
    );
  }
}
