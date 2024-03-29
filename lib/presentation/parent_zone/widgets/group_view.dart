import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../../data/models/teacher_model.dart';
import '../bloc/teacher_list_bloc/teacher_list_bloc.dart';
import 'message_view.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  void initState() {
    context.read<TeacherListBloc>().add(const TeacherListEvent.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherListBloc, TeacherListState>(
      builder: (context, state) {
        switch (state.status) {
          case TeacherListStatus.loading:
            return const Center(
                child: CircularProgressIndicator.adaptive(
              strokeCap: StrokeCap.round,
            ));
          case TeacherListStatus.initial:
            return const Center(
                child: CircularProgressIndicator.adaptive(
              strokeCap: StrokeCap.round,
            ));
          case TeacherListStatus.error:
            return Center(child: Text(state.errorMessage));
          case TeacherListStatus.loaded:
            if (state.teachersList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No Messages Available at the Moment',
                      style: AppTextStyles.nunito105w700Text,
                    ),
                    SizedBox(
                      height: DeviceType().isMobile ? kToolbarHeight : 80.h,
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: state.teachersList.length,
              itemBuilder: (BuildContext context, int index) {
                // var notification = dummyNotification[index];
                TeacherModel teacher = state.teachersList[index];
                print('latests msg: ${state.teacherMessage[index]?.content}');
                return GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MessageView(
                              teaherUserId: teacher.teacherUserId,
                              subject:
                                  state.teacherMessage[index]?.subject ?? '',
                              teacher:
                                  teacher.teacherName.replaceAll('Mr.', ''),
                            )));
                  },
                  child: GroupNotification(
                    subject: teacher.teacherName.contains(' ')
                        ? teacher.teacherName
                                .replaceAll('Mr.', '')
                                .split(' ')
                                .first[0] +
                            teacher.teacherName
                                .replaceAll('Mr.', '')
                                .split(' ')[1][0]
                        : teacher.teacherName.replaceAll('Mr.', '')[
                            0], //state.teacherMessage?.subject ?? '',
                    title: teacher.teacherName.replaceAll('Mr.', ''),
                    subtitle: state.teacherMessage[index]?.content ?? '',
                    isNow: false,
                    trailing: state.teacherMessage[index]?.date == null
                        ? ''
                        : DateFormat('d/M').format(DateTime.parse(
                            parseDate(state.teacherMessage[index]!.date))),
                    // teacher.teacherCreatedDate.toString().split(' ').first,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return 4.verticalSpacer;
              },
            );
        }
      },
    );
  }

  String parseDate(String dateString) {
    List<String> dateParts = dateString.split('-');
    if (dateParts.length == 3) {
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);
      String formattedDate =
          '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      return formattedDate;
    } else {
      throw FormatException('Invalid date format: $dateString');
    }
  }
}

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
                padding: const EdgeInsets.all(10),
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
                        fontSize:
                            75.sp * MediaQuery.of(context).size.aspectRatio),
              ),
            ),
        ],
      ),
    );
  }
}
