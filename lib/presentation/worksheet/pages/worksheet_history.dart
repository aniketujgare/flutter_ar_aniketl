import 'dart:convert';
import 'dart:developer';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../data/models/student_profile_model.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../bloc/worksheet_cubit/worksheet_cubit.dart';
import '../bloc/worksheet_history_page_cubit/worksheet_history_page_cubit.dart';
import 'worksheet_solver.dart';

class WorksheetHistoryView extends StatefulWidget {
  const WorksheetHistoryView({super.key});

  @override
  State<WorksheetHistoryView> createState() => _WorksheetHistoryViewState();
}

class _WorksheetHistoryViewState extends State<WorksheetHistoryView> {
  @override
  void initState() {
    super.initState();

    // context.read<WorksheetCubit>().getWorksheetsHistory();
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
                'Submitted Worksheets',
                style: DeviceType().isMobile
                    ? AppTextStyles.uniformRounded136BoldAppBarStyle
                    : AppTextStyles.uniformRounded136BoldAppBarStyle
                        .copyWith(fontSize: 136.sp * 0.7),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WorksheetHistoryView()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
                  height: 36.h,
                  width: 36.h,
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
                    context.read<WorksheetHistoryPageCubit>().setmaxLength(
                        (BlocProvider.of<WorksheetCubit>(context)
                                    .state
                                    .historyWorksheets
                                    .length /
                                (DeviceType().isMobile ? 4 : 3))
                            .ceil());
                    return BlocBuilder<WorksheetHistoryPageCubit, int>(
                      builder: (context, index) {
                        if (state.historyWorksheets.isEmpty) {
                          return Center(
                            child: Text(
                              'No Worksheets Available at the Moment',
                              style: AppTextStyles.nunito105w700Text,
                            ),
                          );
                        }
                        return PageView.builder(
                          controller: context
                              .read<WorksheetHistoryPageCubit>()
                              .pageCont,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            context
                                .read<WorksheetHistoryPageCubit>()
                                .setPage(value);
                          },
                          itemCount: context
                              .read<WorksheetHistoryPageCubit>()
                              .maxLen, // Number of pages
                          itemBuilder: (context, page) {
                            int startIndex =
                                page * (DeviceType().isMobile ? 4 : 3);
                            int endIndex =
                                (page + 1) * (DeviceType().isMobile ? 4 : 3);

                            // Ensure endIndex does not exceed the total number of elements
                            endIndex = endIndex > state.historyWorksheets.length
                                ? state.historyWorksheets.length
                                : endIndex;

                            // Create a list of widgets for this page
                            List<Widget> pageWidgets = [];

                            for (int i = startIndex; i < endIndex; i++) {
                              var workSheet = state.historyWorksheets[i];
                              pageWidgets.add(
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WorksheetSolverView(
                                            workSheetId: workSheet.id,
                                            isEditable: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Lesson(
                                      worksheetTitle: workSheet.worksheetName,
                                      subject: workSheet.subject,
                                      date: worksheet[i % worksheet.length][2],
                                      teacher: workSheet.teacher,
                                      allQuestionCount:
                                          workSheet.allQuestionCount,
                                      solvedQuestionCount:
                                          workSheet.solvedQuestinCount,
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
                  if (state.historyWorksheets.isNotEmpty) {
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
                                      .read<WorksheetHistoryPageCubit>()
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
                                      .read<WorksheetHistoryPageCubit>()
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
  ['Name of worksheet', 'EVS', '29 Feb 24', 'H. K. Das'],
];

class Lesson extends StatelessWidget {
  final String worksheetTitle;
  final String subject;
  final String date;
  final String teacher;
  final int solvedQuestionCount;
  final int allQuestionCount;
  const Lesson({
    super.key,
    required this.worksheetTitle,
    required this.subject,
    required this.date,
    required this.teacher,
    required this.solvedQuestionCount,
    required this.allQuestionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: DeviceType().isMobile ? 4.wp : 15.wp),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.8.wp),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.wp, horizontal: 3.wp),
          child: Column(
            children: [
              Expanded(
                flex: DeviceType().isMobile ? 10 : 9,
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
                      borderRadius: BorderRadius.circular(
                          DeviceType().isMobile ? 101.sp : 70.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: DeviceType().isMobile ? 1.wp : 1.5.wp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subject,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff212121),
                          fontSize: DeviceType().isMobile ? 16 : 65.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
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
                  color: const Color(0xFF9CDDB6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DeviceType().isMobile ? 95.sp : 60.sp)),
                ),
                child: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF074C2B),
                    fontSize: DeviceType().isMobile ? 20 : 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Spacer(flex: DeviceType().isMobile ? 1 : 1),
              //!Stars
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceType().isMobile ? 12.h : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(5, (index) {
                    List<int> flexs = [3, 4, 5, 4, 3];
                    List<bool> colors = [true, true, true, false, false];
                    return Expanded(
                      flex: flexs[index],
                      child: Image.asset(
                        'assets/images/PNG Icons/star single.png',
                        color: colors[index] ? null : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
              Spacer(flex: DeviceType().isMobile ? 1 : 1),
              //!Remaining questions
              Text(
                "$allQuestionCount/$allQuestionCount",
                style: const TextStyle(
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
                padding: EdgeInsets.symmetric(
                    vertical: DeviceType().isMobile ? 3.wp : 1.8.wp),
                decoration: ShapeDecoration(
                  color: const Color(0xFF45C375),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DeviceType().isMobile ? 111.sp : 70.sp)),
                ),
                child: Text(
                  'View',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.nunito80w700white.copyWith(
                      fontSize: DeviceType().isMobile ? 100.sp : 68.sp),
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
