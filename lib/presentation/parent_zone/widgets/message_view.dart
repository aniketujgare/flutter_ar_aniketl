import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.parentZoneScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        leading: GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(left: 200.w),
            child: Image.asset(
              'assets/images/reusable_icons/back_button_primary.png',
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 3.wp),
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('EVS',
                    style: AppTextStyles.nunito100w700white
                        .copyWith(fontSize: 85.sp)),
              ),
            ),
            5.horizontalSpacer,
            Text(
              'Teacher Name',
              style: AppTextStyles.uniformRounded136BoldAppBarStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: DeviceType().isMobile
            ? EdgeInsets.fromLTRB(8.wp, 40.h, 8.wp, 40.h)
            : EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //! PDF Document
              Column(
                children: [
                  Container(
                    width: 40.wp,
                    height: 259.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.wp),
                          topRight: Radius.circular(4.wp),
                        ),
                      ),
                    ),
                    child: const Center(child: Text('Some PDF')),
                  ),
                  Container(
                    width: 40.wp,
                    height: 80.h,
                    clipBehavior: Clip.antiAlias,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.wp, vertical: 12.h),
                    decoration: ShapeDecoration(
                      color: AppColors.redMessageSharedFileContainerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.wp),
                          bottomRight: Radius.circular(4.wp),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            child: Text('Holiday tomorrow.pdf',
                                style: AppTextStyles.nunito100w400white
                                    .copyWith(fontSize: 75.sp)),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: 100.w,
                            padding: EdgeInsets.symmetric(vertical: 2.2.wp),
                            child: Image.asset(
                              'assets/images/PNG Icons/download_button.png',
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //! View Lesson
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3:11 PM Dec 21',
                      style: AppTextStyles.nunito62w400TextItalic,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 239.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.wp)),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'EVS Lesson:\n',
                                  style: AppTextStyles.nunito88w400Text,
                                ),
                                TextSpan(
                                  text: 'Parts of a Plant',
                                  style: AppTextStyles.nunito88w700Text,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.verticalSpacer,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Published on:\n',
                                  style: AppTextStyles.nunito88w400Text,
                                ),
                                TextSpan(
                                  text: 'April 28, 2023',
                                  style: AppTextStyles.nunito88w700Text,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.verticalSpacer,
                          ReusableButton(
                            padding: EdgeInsets.symmetric(horizontal: 4.wp),
                            onPressed: () {},
                            buttonColor: AppColors.primaryColor,
                            text: 'View Lesson',
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //!Message
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3:11 PM Dec 21',
                      style: AppTextStyles.nunito62w400TextItalic,
                    ),
                    Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(3.wp),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppColors.messageContainerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.wp)),
                          ),
                        ),
                        child: Text(
                          'Hello parents this is a test message. Test message 1,2,3,4 @ school. We are delighted to announce that the schools is deploying a new learning ecosystem for the school. It is being rolled out as we speak. It is going to help sudents learn better and help teachers teach smarter. All while keeping you in the leap. Hope you’re as excited as us about SmartXR!',
                          style: AppTextStyles.nunito88w400Text,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
