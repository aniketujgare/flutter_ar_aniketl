import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.maxFinite,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.h),
        ),
      ),
      padding: DeviceType().isMobile
          ? EdgeInsets.fromLTRB(0, 40.h, 0, 40.h)
          : EdgeInsets.fromLTRB(0, 40.h, 0, 30.h),
      margin: DeviceType().isMobile
          ? EdgeInsets.fromLTRB(170.w, 30.h, 170.w, 0.h)
          : EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 30.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.wp, vertical: 3.hp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 40.verticalSpacer,
            SizedBox(
              width: double.infinity,
              child: Text(
                'COMING SOON!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4F3A9C),
                  fontSize: 170.sp,
                  fontFamily: 'Uniform Rounded',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            30.verticalSpacer,
            Image.asset('assets/images/reusable_icons/dounut_circles.png'),
            30.verticalSpacer,
            Text(
              'The reports feature is highly anticipated by parents. Our reports are being built to go beyond academics. They will cover 3 areas broadly - Everyday Skills, Comprehension and Cognition. These will be further divided into detailed parameters that will give you real time information about your child’s progress.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 120.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
