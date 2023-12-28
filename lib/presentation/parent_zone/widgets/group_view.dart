import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/data/models/teacher_model.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/message_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:size_config/size_config.dart';

import '../bloc/teacher_list_bloc/teacher_list_bloc.dart';
import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  void initState() {
    context.read<TeacherListBloc>().add(TeacherListEvent.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherListBloc, TeacherListState>(
      builder: (context, state) {
        switch (state.status) {
          case TeacherListStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case TeacherListStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case TeacherListStatus.error:
            return Center(child: Text(state.errorMessage));
          case TeacherListStatus.loaded:
            return ListView.separated(
              itemCount: state.teachersList.length,
              itemBuilder: (BuildContext context, int index) {
                // var notification = dummyNotification[index];
                var teacher = state.teachersList[index];
                return GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MessageView()));
                  },
                  child: GroupNotification(
                    subject: teacher.teacherName[0] +
                        teacher.teacherName.split(' ').last[0],
                    title: teacher.teacherName,
                    subtitle: teacher.teacherName,
                    isNow: false,
                    trailing:
                        DateFormat('d/M').format(teacher.teacherCreatedDate),
                    // teacher.teacherCreatedDate.toString().split(' ').first,
                  ),
                );

                // return GestureDetector(
                //   onTap: () async {
                //     Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => MessageView()));
                //   },
                //   child: GroupNotification(
                //     subject: notification['subject'] as String,
                //     title: notification['title'] as String,
                //     subtitle: notification['subtitle'] as String,
                //     isNow: notification['isNow'] as bool,
                //     trailing: notification['trailing'] as String,
                //   ),
                // );
              },
              separatorBuilder: (BuildContext context, int index) {
                return 4.verticalSpacer;
              },
            );
        }
      },
    );
  }
}

// var dummyNotification = [
//   {
//     'subject': 'EVS',
//     'title': 'Snehal Kulkarni',
//     'subtitle': 'Sports day on the 18th of April 2023.',
//     'isNow': true,
//     'trailing': '',
//   },
//   {
//     'subject': 'ENG',
//     'title': 'Snehal Kulkarni',
//     'subtitle': 'Sports day on the 18th of April 2023.',
//     'isNow': false,
//     'trailing': 'Mon',
//   },
//   {
//     'subject': 'Math',
//     'title': 'Snehal Kulkarni',
//     'subtitle': 'Sports day on the 18th of April 2023.',
//     'isNow': false,
//     'trailing': '21/12',
//   },
//   {
//     'subject': 'Hin',
//     'title': 'Snehal Kulkarni',
//     'subtitle': 'Sports day on the 18th of April 2023.',
//     'isNow': false,
//     'trailing': '11/11',
//   },
// ];

class GroupNotification extends StatelessWidget {
  final String subject;
  final String title;
  final String subtitle;
  final bool isNow;
  final String trailing;
  const GroupNotification(
      {super.key,
      required this.subject,
      required this.title,
      required this.subtitle,
      this.isNow = false,
      this.trailing = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5.wp, vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 3.wp),
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  subject,
                  style: AppTextStyles.nunito115w700white,
                ),
              ),
            ),
          ),
          5.horizontalSpacer,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                SizedBox(
                  child: Text(
                    title,
                    style: DeviceType().isMobile
                        ? AppTextStyles.nunito105w700Text
                        : AppTextStyles.nunito105w700Text.copyWith(
                            fontSize: 105.sp *
                                1 /
                                MediaQuery.of(context).size.aspectRatio),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      // softWrap: true, // Allow the text to wrap
                      style: DeviceType().isMobile
                          ? AppTextStyles.nunito85w400Text
                          : AppTextStyles.nunito85w400Text.copyWith(
                              fontSize: 85.sp *
                                  1 /
                                  MediaQuery.of(context).size.aspectRatio),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isNow)
            Container(
              margin: EdgeInsets.only(left: 6.wp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Now',
                    textAlign: TextAlign.center,
                    style: DeviceType().isMobile
                        ? AppTextStyles.nunito75w400Text
                        : AppTextStyles.nunito75w400Text.copyWith(
                            fontSize: 75.sp *
                                1 /
                                MediaQuery.of(context).size.aspectRatio),
                  ),
                  5.verticalSpacer,
                  CircleAvatar(
                    radius: DeviceType().isMobile ? 60.w : 40.w,
                    backgroundColor: const Color(0xFFFF644E),
                    child: Text(
                      '4',
                      textAlign: TextAlign.center,
                      style: DeviceType().isMobile
                          ? AppTextStyles.nunito75w700TextWhite
                          : AppTextStyles.nunito75w700TextWhite.copyWith(
                              fontSize: 75.sp *
                                  1 /
                                  MediaQuery.of(context).size.aspectRatio),
                    ),
                  )
                ],
              ),
            ),
          if (!isNow)
            Container(
              margin: EdgeInsets.only(left: 6.wp),
              child: Text(
                trailing,
                textAlign: TextAlign.center,
                style: DeviceType().isMobile
                    ? AppTextStyles.nunito75w400Text
                    : AppTextStyles.nunito75w400Text.copyWith(
                        fontSize: 75.sp *
                            1 /
                            MediaQuery.of(context).size.aspectRatio),
              ),
            ),
        ],
      ),
    );
  }
}
