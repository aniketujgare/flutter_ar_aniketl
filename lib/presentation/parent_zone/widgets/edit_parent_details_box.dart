import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_textfield.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';

class EditParentDetailsBox extends StatelessWidget {
  final String profileName;
  const EditParentDetailsBox(
    this.profileName, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceType().isMobile ? 340.h : 440.h,
      width: DeviceType().isMobile ? 90.wp : 60.wp,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 25.h, bottom: DeviceType().isMobile ? 25.h : 18.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$profileName\'s Profile',
              style: AppTextStyles.nunito105w700Text.copyWith(fontSize: 120.sp),
            ),
            ReusableTextField(
              countryCodeVisible: false,
              hintText: 'Enter $profileName\'s full name',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceType().isMobile ? 8.wp : 4.wp),
              child: Text(
                'To change email ID or phone number, please contact your school.',
                textAlign: TextAlign.center,
                style: AppTextStyles.nunito88w400Text.copyWith(fontSize: 85.sp),
                // textAlign: TextAlign.justify,
              ),
            ),
            2.verticalSpacer,
            ReusableButton(
              circularRadius: 30.h,
              fontSize: 100.sp,
              padding: EdgeInsets.symmetric(horizontal: 26.wp),
              onPressed: () {},
              buttonColor: AppColors.submitGreenColor,
              text: 'Done',
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
