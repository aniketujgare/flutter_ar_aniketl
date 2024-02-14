import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';

class WorksheetSubmittedBox extends StatelessWidget {
  const WorksheetSubmittedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              color: const Color(0XFFBCBCBC),
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
                  top: 13.h, bottom: DeviceType().isMobile ? 13.h : 18.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Worksheet Submitted!',
                    style: AppTextStyles.nunito120w700primary,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceType().isMobile ? 14.wp : 11.wp),
                    child: Image.asset(
                      'assets/images/PNG Icons/stars 5.png',
                    ),
                  ),
                  2.verticalSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Image.asset(
                            'assets/images/PNG Icons/esr.002.png', // User Icon
                            width: DeviceType().isMobile ? 22.wp : 17.wp,
                            fit: BoxFit.contain,
                          ),
                          // SizedBox(
                          //   width: DeviceType().isMobile ? 15.wp : 9.wp,
                          //   child: FittedBox(
                          //     fit: BoxFit.scaleDown,
                          //     child: Text(
                          //       '999',
                          //       textAlign: TextAlign.center,
                          //       style: DeviceType().isMobile
                          //           ? AppTextStyles.nunito100w700white
                          //           : AppTextStyles.nunito100w700white.copyWith(
                          //               fontSize: 60.sp *
                          //                   MediaQuery.of(context).size.aspectRatio),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      2.horizontalSpacerPercent,
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Image.asset(
                            'assets/images/PNG Icons/esr.001.png', // User Icon
                            width: DeviceType().isMobile ? 22.wp : 17.wp,
                            fit: BoxFit.contain,
                          ),
                          // SizedBox(
                          //   width: DeviceType().isMobile ? 15.wp : 9.wp,
                          //   child: FittedBox(
                          //     fit: BoxFit.scaleDown,
                          //     child: Text(
                          //       '999',
                          //       textAlign: TextAlign.center,
                          //       style: DeviceType().isMobile
                          //           ? AppTextStyles.nunito100w700white
                          //           : AppTextStyles.nunito100w700white.copyWith(
                          //               fontSize: 60.sp *
                          //                   MediaQuery.of(context).size.aspectRatio),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Solved',
                          style: AppTextStyles.nunito75w400Text,
                        ),
                        Text(
                          ' 30/30',
                          style: AppTextStyles.nunito105w700Text,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+5',
                        style: AppTextStyles.nunito120w700primary.copyWith(
                            fontWeight: FontWeight.w900, fontSize: 80.sp),
                      ),
                      Image.asset(
                        'assets/images/PNG Icons/coin.png', // User Icon
                        width: 4.wp,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DeviceType().isMobile ? 50.h : 60.h,
                    child: ReusableButton(
                      circularRadius: 10.h,
                      fontSize: 90.sp,
                      padding: EdgeInsets.symmetric(horizontal: 4.wp),
                      onPressed: () {},
                      buttonColor: AppColors.primaryColor,
                      text: 'View Graded Worksheet',
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
