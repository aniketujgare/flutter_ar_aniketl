import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: AppColors.parentZoneScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
                height: 36.h,
                width: 36.h,
                child: Image.asset(
                  'assets/images/reusable_icons/back_button_primary.png',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 1.wp),
              height: DeviceType().isMobile ? 56.h : 50.h,
              width: DeviceType().isMobile ? 56.h : 50.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('EVS',
                    style: DeviceType().isMobile
                        ? AppTextStyles.nunito85w700white
                        : AppTextStyles.nunito85w700white
                            .copyWith(fontSize: 85.sp * 0.7, height: 0)),
              ),
            ),
            // 5.horizontalSpacer,
            Text(
              'Teacher Name',
              style: DeviceType().isMobile
                  ? AppTextStyles.uniformRounded136BoldAppBarStyle
                  : AppTextStyles.uniformRounded136BoldAppBarStyle
                      .copyWith(fontSize: 136.sp * 0.7),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(4.wp, 0, 4.wp, 0),
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
                    // height: 78.h,
                    clipBehavior: Clip.antiAlias,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.wp, vertical: 10.h),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.nunito100w400white
                                    .copyWith(fontSize: 75.sp)),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 45.h,
                            // height: 45.h,
                            padding: EdgeInsets.symmetric(vertical: 1.wp),
                            child: Image.asset(
                              'assets/images/PNG Icons/download_button.png',
                              fit: BoxFit.fitWidth,
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
                      // height: 239.h,
                      padding: EdgeInsets.symmetric(vertical: 3.wp),
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
