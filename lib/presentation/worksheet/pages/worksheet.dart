import 'dart:convert';
import 'dart:developer';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/data/models/student_profile_model.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../data/models/teacher_message.dart';
import '../../parent_zone/bloc/teacher_message_cubit/teacher_message_cubit.dart';
import '../bloc/worksheet_cubit/worksheet_cubit.dart';
import 'worksheet_history.dart';
import 'worksheet_solver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../bloc/worksheet_page_cubit/worksheet_page_cubit.dart';

class WorksheetView extends StatefulWidget {
  const WorksheetView({super.key});
  @override
  State<WorksheetView> createState() => _WorksheetViewState();
}

class _WorksheetViewState extends State<WorksheetView> {
  late StudentProfileModel studentProfileModel;
  @override
  void initState() {
    context.read<WorksheetPageCubit>().setPage(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        appBar: AppBar(
          toolbarHeight: DeviceType().isMobile ? 56 : 80,
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
              const Spacer(),
              Text(
                'Worksheets',
                style: DeviceType().isMobile
                    ? AppTextStyles.uniformRounded136BoldAppBarStyle
                    : AppTextStyles.uniformRounded136BoldAppBarStyle
                        .copyWith(fontSize: 136.sp * 0.7),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  StudentProfileModel? v =
                      await AuthenticationRepository().getStudentProfile();
                  log(jsonEncode(v));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WorksheetHistoryView()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
                  height: 36.h,
                  width: 36.h,
                  child: Image.asset(
                    'assets/images/PNG Icons/history.png',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ConnectionNotifierToggler(
          disconnected: const NetworkDisconnected(),
          connected: Stack(
            children: [
              BlocBuilder<WorksheetCubit, WorksheetState>(
                builder: (context, state) {
                  if (state.status == WorksheetStatus.loaded) {
                    context.read<WorksheetPageCubit>().setmaxLength(
                        (BlocProvider.of<WorksheetCubit>(context)
                                    .state
                                    .worksheets
                                    .length /
                                (DeviceType().isMobile ? 4 : 3))
                            .ceil());
                    return BlocBuilder<WorksheetPageCubit, int>(
                      builder: (context, index) {
                        if (state.worksheets.isEmpty) {
                          return Center(
                            child: Text(
                              'No Worksheets Available at the Moment',
                              style: AppTextStyles.nunito105w700Text,
                            ),
                          );
                        }
                        return PageView.builder(
                          controller:
                              context.read<WorksheetPageCubit>().pageCont,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            context.read<WorksheetPageCubit>().setPage(value);
                          },
                          itemCount: context
                              .read<WorksheetPageCubit>()
                              .maxLen, // Number of pages
                          itemBuilder: (context, page) {
                            int startIndex =
                                page * (DeviceType().isMobile ? 4 : 3);
                            int endIndex =
                                (page + 1) * (DeviceType().isMobile ? 4 : 3);

                            // Ensure endIndex does not exceed the total number of elements
                            endIndex = endIndex > state.worksheets.length
                                ? state.worksheets.length
                                : endIndex;

                            // Create a list of widgets for this page
                            List<Widget> pageWidgets = [];

                            for (int i = startIndex; i < endIndex; i++) {
                              var workSheet = state.worksheets[i];
                              pageWidgets.add(
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WorksheetSolverView(
                                                  workSheetId: 850),
                                        ),
                                      );
                                    },
                                    child: Lesson(
                                      worksheetTitle: workSheet.worksheetName,
                                      subject: workSheet.subject,
                                      date: worksheet[i % worksheet.length][2],
                                      teacher: workSheet.teacher,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (pageWidgets.length <
                                (DeviceType().isMobile ? 4 : 3)) {
                              for (int i = pageWidgets.length;
                                  i < (DeviceType().isMobile ? 4 : 3);
                                  i++) {
                                pageWidgets.add(const Expanded(
                                  child: SizedBox(),
                                ));
                              }
                            }

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.wp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: pageWidgets,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                          strokeCap: StrokeCap.round),
                    );
                  }
                },
              ),
              BlocBuilder<WorksheetCubit, WorksheetState>(
                builder: (context, state) {
                  if (state.worksheets.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                      child: Column(
                        children: [
                          //! Center page previous and next buttons
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => context
                                      .read<WorksheetPageCubit>()
                                      .setPreviousPage(),
                                  child: SizedBox(
                                    height: 45.h,
                                    width: 45.h,
                                    child: Image.asset(
                                      'assets/ui/Group.png', // right arrow
                                      fit: BoxFit.scaleDown,
                                      height: 45.h,
                                      width: 45.h,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context
                                      .read<WorksheetPageCubit>()
                                      .setNextPage(),
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: SizedBox(
                                      height: 45.h,
                                      width: 45.h,
                                      child: Image.asset(
                                        'assets/ui/Group.png', // right arrow
                                        fit: BoxFit.scaleDown,
                                        height: 45.h,
                                        width: 45.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var worksheet = [
  ['Living and non-living things', 'EVS', '26 Jan 24', 'Teacher\'s Name'],
  ['Vowels and Noun', 'English', '28 Jan 24', 'D. C. Pandey'],
  ['Fraction and Division', 'Maths', '29 Jan 24', 'H. C. Verma'],
  ['Name of worksheet', 'EVS', '30 Feb 24', 'H. K. Das'],
];

class Lesson extends StatelessWidget {
  final String worksheetTitle;
  final String subject;
  final String date;
  final String teacher;

  const Lesson({
    super.key,
    required this.worksheetTitle,
    required this.subject,
    required this.date,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: DeviceType().isMobile ? 5.wp : 15.wp),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.8.wp),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  margin: EdgeInsets.only(top: 3.wp),
                  child: Text(
                    worksheetTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4F3A9C),
                      fontSize: DeviceType().isMobile ? 18 : 25,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              //!Subject And Teacher Name
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 2.wp),
                decoration: ShapeDecoration(
                  color: const Color(0xFFB3EAFC),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.wp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subject,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff212121),
                          fontSize: DeviceType().isMobile ? 16 : 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        teacher,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff212121),
                          fontSize: DeviceType().isMobile ? 16 : 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              //!Date
              Container(
                width: double.maxFinite,
                padding:
                    EdgeInsets.symmetric(vertical: 1.3.wp, horizontal: 2.wp),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFC1B8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA94234),
                    fontSize: DeviceType().isMobile ? 20 : 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              //!Remaining questions
              const Text(
                "0/30",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff212121),
                  height: 40 / 32,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              //!Solve
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 3.wp),
                padding: EdgeInsets.symmetric(vertical: 3.wp, horizontal: 2.wp),
                decoration: ShapeDecoration(
                  color: const Color(0xFF45C375),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                child: Text(
                  'Solve',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.nunito100w700white,
                ),
              ),
            ],
          ),
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
