import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_ar/data/models/teacher_message.dart';
import 'package:flutter_ar/presentation/parent_zone/bloc/teacher_message_cubit/teacher_message_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';

class MessageView extends StatefulWidget {
  final int teaherUserId;
  const MessageView({super.key, required this.teaherUserId});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.parentZoneScaffoldColor));
    context.read<TeacherMessageCubit>().loadMessages('${widget.teaherUserId}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.accentColor,
          leading: null,
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
          child: BlocBuilder<TeacherMessageCubit, TeacherMessageState>(
            builder: (context, state) {
              switch (state.status) {
                case TeacherMessageStatus.initial:
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                  ));
                case TeacherMessageStatus.loading:
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                  ));
                case TeacherMessageStatus.error:
                  return const Center(child: Text('Failed to load messages'));
                case TeacherMessageStatus.loaded:
                  return ListView.separated(
                    // reverse: true,
                    itemCount: state.teachersMessages.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 20.h);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var message = state.teachersMessages[index];
                      switch (message.type) {
                        //! View Lesson
                        case "lesson":
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // message.date + message.time,
                                  DateFormat('h:mm a MMM d').format(
                                      createDateTime(
                                          message.date, message.time)),
                                  // '3:11 PM Dec 21',
                                  style: AppTextStyles.nunito62w400TextItalic,
                                ),
                                Container(
                                  width: 50.wp,
                                  // height: 239.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.wp, horizontal: 2.wp),
                                  decoration: ShapeDecoration(
                                    color: AppColors.accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.wp)),
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
                                              text: '${message.subject}\n',
                                              // 'EVS Lesson:\n',
                                              style: AppTextStyles
                                                  .nunito88w400Text,
                                            ),
                                            TextSpan(
                                              text: message.content,
                                              // 'Parts of a Plant',
                                              style: AppTextStyles
                                                  .nunito88w700Text,
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
                                              style: AppTextStyles
                                                  .nunito88w400Text,
                                            ),
                                            TextSpan(
                                              text: DateFormat('MMM d, yyyy')
                                                  .format(convertToDate(
                                                      message.date)),
                                              // 'April 28, 2023',
                                              style: AppTextStyles
                                                  .nunito88w700Text,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      10.verticalSpacer,
                                      ReusableButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
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
                          );

                        case "text":
                          return //!Message
                              Container(
                            margin: EdgeInsets.only(bottom: 10.h),
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
                                    decoration: ShapeDecoration(
                                      color: AppColors.messageContainerColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.wp)),
                                      ),
                                    ),
                                    child: Text(
                                      message.content,
                                      style: AppTextStyles.nunito88w400Text,
                                    )),
                              ],
                            ),
                          );
                      }
                    },
                  );
              }
            },
          ),
          /*
          SingleChildScrollView(
            child: 
            
            Column(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.wp, vertical: 10.h),
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
                        width: 50.wp,
                        // height: 239.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 3.wp, horizontal: 2.wp),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppColors.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.wp)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
                  margin: EdgeInsets.only(bottom: 40.h),
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
          */
        ),
      ),
    );
  }
}

DateTime createDateTime(String dateStr, String timeStr) {
  List<int> dateParts =
      dateStr.split('-').map((part) => int.parse(part)).toList();

  List<String> timeParts = timeStr.split(' ');
  List<int> timeHourMinute =
      timeParts[0].split(':').map((part) => int.parse(part)).toList();

  int hour = timeHourMinute[0];
  int minute = timeHourMinute[1];

  if (timeParts[1] == 'pm' && hour != 12) {
    hour += 12;
  }

  return DateTime(dateParts[0], dateParts[1], dateParts[2], hour, minute);
}

DateTime convertToDate(String dateString) {
  List<int> dateParts =
      dateString.split('-').map((part) => int.parse(part)).toList();
  return DateTime(dateParts[0], dateParts[1], dateParts[2]);
}
