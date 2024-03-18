import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/constants.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_textfield.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/data/models/parent_details.dart';
import 'package:flutter_ar/presentation/parent_zone/bloc/parent_details_cubit/parent_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/util/device_type.dart';

class EditParentDetailsBox extends StatelessWidget {
  final String profileTitle;
  final ParentDetails parentDetails;
  final BuildContext oldContext;
  EditParentDetailsBox({
    super.key,
    required this.profileTitle,
    required this.parentDetails,
    required this.oldContext,
  });
  String updatedProfileName = '';
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
              '$profileTitle\'s Profile',
              style: AppTextStyles.nunito105w700Text.copyWith(fontSize: 120.sp),
            ),
            ReusableTextField(
              onChanged: (value) => updatedProfileName = value,
              countryCodeVisible: false,
              hintText: 'Enter $profileTitle\'s full name',
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
              padding: EdgeInsets.symmetric(horizontal: 18.wp),
              onPressed: () async {
                //? Send data to Api
                if (updatedProfileName.isEmpty) {
                  // Constants()
                  //     .showAppSnackbar(context, 'Name should not be empty!');
                  if (context.mounted) {
                    print('empty parent name');
                    Constants().showAppSnackbar(
                        oldContext, 'Name should not be empty!');
                    await Future.delayed(const Duration(seconds: 4)).then(
                        (value) => ScaffoldMessenger.of(oldContext)
                            .removeCurrentSnackBar());
                  }
                  // return;
                } else {
                  var newParent =
                      parentDetails.copyWith(parentName: updatedProfileName);
                  oldContext
                      .read<ParentDetailsCubit>()
                      .updateParentDeatail(newParent);
                  print('updated');
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
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
