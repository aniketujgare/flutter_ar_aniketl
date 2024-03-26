import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../util/device_type.dart';
import '../util/reusable_widgets/reusable_button.dart';
import '../util/styles.dart';

Future showFeatureComingSoonAertBox(
    BuildContext context, String description) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Dialog(
            child: Stack(
          alignment: Alignment.center,
          children: [
            // SizedBox.expand(),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              height: DeviceType().isMobile ? 410.h : 550.h,
              width: DeviceType().isMobile ? 75.wp : 60.wp,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20.h),
                border: Border.all(
                  width: 60.sp,
                  color: Color(0XFFBCBCBC),
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
            Container(
              height: DeviceType().isMobile ? 400.h : 540.h,
              width: DeviceType().isMobile ? 75.wp : 60.wp,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20.h),
                border: Border.all(
                  width: 60.sp,
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(20.h),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: DeviceType().isMobile ? 13.h : 18.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coming Soon!',
                        style: AppTextStyles.nunito120w700primary,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.nunito105w700Text,
                      ),
                      ReusableButton(
                        circularRadius: 10.h,
                        fontSize: 90.sp,
                        padding: EdgeInsets.symmetric(horizontal: 2.wp),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        buttonColor: AppColors.primaryColor,
                        text: 'Back',
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      );
    },
  );
}
