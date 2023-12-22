import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: dummyNotification.length,
      itemBuilder: (BuildContext context, int index) {
        var notification = dummyNotification[index];
        return GroupNotification(
          subject: notification['subject'] as String,
          title: notification['title'] as String,
          subtitle: notification['subtitle'] as String,
          isNow: notification['isNow'] as bool,
          trailing: notification['trailing'] as String,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return 4.verticalSpacer;
      },
    );
  }
}

var dummyNotification = [
  {
    'subject': 'EVS',
    'title': 'Snehal Kulkarni',
    'subtitle': 'Sports day on the 18th of April 2023.',
    'isNow': true,
    'trailing': '',
  },
  {
    'subject': 'ENG',
    'title': 'Snehal Kulkarni',
    'subtitle': 'Sports day on the 18th of April 2023.',
    'isNow': false,
    'trailing': 'Mon',
  },
  {
    'subject': 'Math',
    'title': 'Snehal Kulkarni',
    'subtitle': 'Sports day on the 18th of April 2023.',
    'isNow': false,
    'trailing': '21/12',
  },
  {
    'subject': 'Hin',
    'title': 'Snehal Kulkarni',
    'subtitle': 'Sports day on the 18th of April 2023.',
    'isNow': false,
    'trailing': '11/11',
  },
];

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
            child: Center(
              child: Text(
                subject,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 115.sp,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
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
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 105.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      // softWrap: true, // Allow the text to wrap
                      style: TextStyle(
                          color: const Color(0xFF4D4D4D),
                          fontSize: 85.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0),
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
                    style: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontSize: 75.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  5.verticalSpacer,
                  CircleAvatar(
                    radius: 60.w,
                    backgroundColor: const Color(0xFFFF644E),
                    child: Text(
                      '4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 75.sp,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
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
                style: TextStyle(
                  color: const Color(0xFF4D4D4D),
                  fontSize: 75.sp,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
