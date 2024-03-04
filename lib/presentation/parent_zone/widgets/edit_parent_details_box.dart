import 'package:flutter/material.dart';
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
  EditParentDetailsBox({
    super.key,
    required this.profileTitle,
    required this.parentDetails,
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

                var newParent =
                    parentDetails.copyWith(parentName: updatedProfileName);

                await updateParentDetails(newParent);
                if (context.mounted) {
                  Navigator.of(context).pop();
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

Future<void> updateParentDetails(ParentDetails parentDetails) async {
  var headers = {'Content-Type': 'application/json'};

  try {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/updateparentdetails'));

    request.body = json.encode({
      "parent_name": parentDetails.parentName,
      "parent_email": parentDetails.parentEmail,
      "parent_relation": parentDetails.parentRelation,
      "parent_id": parentDetails.parentId,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(jsonEncode(parentDetails));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
