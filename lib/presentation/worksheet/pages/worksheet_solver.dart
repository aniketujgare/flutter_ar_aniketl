import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_textfield.dart';
import 'package:flutter_ar/data/models/questions.dart';
import 'package:flutter_ar/presentation/worksheet/bloc/worksheet_ans_of_student_cubit/worksheet_ans_of_student_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../../../data/models/student_worksheet_data.dart';
import '../../../data/models/worksheet_ans_of_student.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

class WorksheetSolverView extends StatefulWidget {
  const WorksheetSolverView({super.key});

  @override
  State<WorksheetSolverView> createState() => _WorksheetSolverViewState();
}

class _WorksheetSolverViewState extends State<WorksheetSolverView> {
  @override
  void initState() {
    context.read<WorksheetSolverCubit>().getWorksheetsData();
    context.read<WorksheetSolverCubit>().getStudentWorksheetData();
    // context.read<WorksheetAnsOfStudentCubit>().getStudentWorksheetData();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.parentZoneScaffoldColor));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  List<Map<String, dynamic>> answers = [];
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
                'Worksheets Solver',
                style: DeviceType().isMobile
                    ? AppTextStyles.uniformRounded136BoldAppBarStyle
                    : AppTextStyles.uniformRounded136BoldAppBarStyle
                        .copyWith(fontSize: 136.sp * 0.7),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
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
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox.expand(
                child: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
              builder: (context, state) {
                if (state.status == WorkSheetSolverStatus.loaded) {
                  List<StudentAnswer> studentAns = state.studentAnswersList;

                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: state.questions.length,
                    padding: EdgeInsets.only(
                        top: DeviceType().isMobile ? 4.wp : 18.wp,
                        left: 4.wp,
                        right: 4.wp,
                        bottom: DeviceType().isMobile ? 4.wp : 18.wp),
                    itemBuilder: (BuildContext context, int i) {
                      switch (state.questions[i].questionType) {
                        case QuestionType.mcqText:
                          McqTextQuestion mcqTextQuestion =
                              state.questions[i] as McqTextQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${i + 1}) ${mcqTextQuestion.question}'),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    (mcqTextQuestion.options.length / 2).ceil(),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      for (int i = index * 2;
                                          i < (index + 1) * 2;
                                          i++)
                                        if (i < mcqTextQuestion.options.length)
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${i + 1}. ${mcqTextQuestion.options[i]}"),
                                            ),
                                          ),
                                    ],
                                  );
                                },
                              ),
                              // Text(mcqTextQuestion.answer),
                            ],
                          );
                        case QuestionType.mcqImage:
                          McqImageQuestion mcqImageQuestion =
                              state.questions[i] as McqImageQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${i + 1}) ${mcqImageQuestion.question}'),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: (mcqImageQuestion.options.length / 2)
                                    .ceil(),
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  int startIndex = rowIndex * 2;
                                  int endIndex = (rowIndex + 1) * 2;
                                  endIndex =
                                      endIndex > mcqImageQuestion.options.length
                                          ? mcqImageQuestion.options.length
                                          : endIndex;

                                  return Row(
                                    children: List.generate(
                                        endIndex - startIndex, (j) {
                                      int optionIndex = startIndex + j;
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text('${optionIndex + 1}.'),
                                              CachedNetworkImage(
                                                imageUrl: mcqImageQuestion
                                                    .options[optionIndex],
                                                width:
                                                    50, // Adjust the width as needed
                                                height:
                                                    50, // Adjust the height as needed
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          );
                        case QuestionType.fillBlank:
                          FillBlankQuestion fillBlankQuestion =
                              state.questions[i] as FillBlankQuestion;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${i + 1}) ${fillBlankQuestion.question}'),
                              const ReusableTextField(
                                hintText: 'Type your answer here',
                                countryCodeVisible: false,
                              )
                            ],
                          );

                        case QuestionType.multiplefillblank:
                          MultipleFillBlankQuestion multipleFillBlankQuestion =
                              state.questions[i] as MultipleFillBlankQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${i}) ${multipleFillBlankQuestion.question}'),
                              Column(
                                children: List.generate(
                                  (multipleFillBlankQuestion.answer.length / 2)
                                      .ceil(),
                                  (rowIndex) {
                                    int startIndex = rowIndex * 2;
                                    int endIndex = (rowIndex + 1) * 2;
                                    endIndex = endIndex >
                                            multipleFillBlankQuestion
                                                .answer.length
                                        ? multipleFillBlankQuestion
                                            .answer.length
                                        : endIndex;

                                    return Row(
                                      children: List.generate(
                                          endIndex - startIndex, (j) {
                                        int optionIndex = startIndex + j;

                                        return Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${j + 1}. ${multipleFillBlankQuestion.answer[optionIndex]}',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        case QuestionType.trueFalse:
                          TrueFalseQuestion trueFalseQuestion =
                              state.questions[i] as TrueFalseQuestion;

                          bool? isTrueSelected = i > studentAns.length
                              ? null
                              : studentAns[i].question.answer.answer == 'True';
                          bool? isFalseSelected = i > studentAns.length
                              ? null
                              : studentAns[i].question.answer.answer == 'False';
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${i + 1}) ${trueFalseQuestion.question}'),
                              Row(
                                children: [
                                  Radio<bool?>(
                                    value: true,
                                    groupValue: isTrueSelected,
                                    onChanged: (bool? value) {
                                      // Handle the onChanged event here if needed
                                      // For example, you can update the state or perform some action
                                      // when the 'True' radio button is selected.
                                    },
                                  ),
                                  const Text('True'),
                                  Radio<bool?>(
                                    value: true,
                                    groupValue: isFalseSelected,
                                    onChanged: (bool? value) {
                                      // Handle the onChanged event here if needed
                                      // For example, you can update the state or perform some action
                                      // when the 'False' radio button is selected.
                                    },
                                  ),
                                  const Text('False'),
                                ],
                              )
                            ],
                          );

                        case QuestionType.matchTheFollowing:
                          MatchTheFollowingQuestion matchTheFollowingQuestion =
                              state.questions[i] as MatchTheFollowingQuestion;
                          var shuffledOptions =
                              matchTheFollowingQuestion.options.entries.toList()
                                ..shuffle();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${i + 1}) ${matchTheFollowingQuestion.questionType}'),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  shuffledOptions.length,
                                  (index) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                matchTheFollowingQuestion
                                                    .options.entries
                                                    .toList()[index]
                                                    .key,
                                                width:
                                                    50, // Adjust the width as needed
                                                height:
                                                    50, // Adjust the height as needed
                                              ),
                                              const SizedBox(
                                                  width:
                                                      186.0), // Add some spacing between image and text
                                              Text(
                                                  shuffledOptions[index].value),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        case QuestionType.oneWord:
                          OneWordQuestion oneWordQuestion =
                              state.questions[i] as OneWordQuestion;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${i + 1}) ${oneWordQuestion.question}'),
                              const ReusableTextField(
                                hintText: 'Type your answer here',
                                countryCodeVisible: false,
                              )
                            ],
                          );
                        case QuestionType.selectWord:
                          SelectWordQuestion selectWordQuestion =
                              state.questions[i] as SelectWordQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${i + 1}) ${selectWordQuestion.question}'),
                              Text(selectWordQuestion.questionType.toString()),
                              const SizedBox(height: 10),
                            ],
                          );
                        case QuestionType.oddOneOutText:
                          OddOneOutTextQuestion oddOneOutTextQuestion =
                              state.questions[i] as OddOneOutTextQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${i + 1}) ${oddOneOutTextQuestion.question}'), // Display the question
                              Column(
                                children: List.generate(
                                  (oddOneOutTextQuestion.options.length / 2)
                                      .ceil(),
                                  (rowIndex) {
                                    int startIndex = rowIndex * 2;
                                    int endIndex = startIndex + 2;
                                    endIndex = endIndex >
                                            oddOneOutTextQuestion.options.length
                                        ? oddOneOutTextQuestion.options.length
                                        : endIndex;

                                    return Row(
                                      children: List.generate(
                                        endIndex - startIndex,
                                        (j) {
                                          int optionIndex = startIndex + j;
                                          return Expanded(
                                            child: ListTile(
                                              title: Text(oddOneOutTextQuestion
                                                  .options[optionIndex]),
                                              leading: Radio<bool>(
                                                value: false,
                                                groupValue: true,
                                                onChanged:
                                                    null, // Set to null to disable interaction
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        case QuestionType.oddOneOutimage:
                          OddOneOutImageQuestion oddOneOutImageQuestion =
                              state.questions[i] as OddOneOutImageQuestion;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${i + 1}) ${oddOneOutImageQuestion.question}'), // Display the question
                              Column(
                                children: List.generate(
                                  (oddOneOutImageQuestion.options.length / 2)
                                      .ceil(),
                                  (rowIndex) {
                                    int startIndex = rowIndex * 2;
                                    int endIndex = startIndex + 2;
                                    endIndex = endIndex >
                                            oddOneOutImageQuestion
                                                .options.length
                                        ? oddOneOutImageQuestion.options.length
                                        : endIndex;

                                    return Row(
                                      children: List.generate(
                                        endIndex - startIndex,
                                        (j) {
                                          int optionIndex = startIndex + j;
                                          return Expanded(
                                            child: ListTile(
                                              title: Image.network(
                                                oddOneOutImageQuestion
                                                    .options[optionIndex],
                                                width:
                                                    50, // Adjust the width as needed
                                                height:
                                                    50, // Adjust the height as needed
                                              ),
                                              leading: Radio<String>(
                                                value: '1',
                                                groupValue:
                                                    null, // You need to set the group value accordingly
                                                onChanged: (String? value) {
                                                  // Handle radio button selection
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        case QuestionType.ascDescOrder:
                          return Text(
                              state.questions[i].questionType.toString());
                        case QuestionType.arithmetic:
                          return Text(
                              state.questions[i].questionType.toString());
                        default:
                          return Text(
                              state.questions[i].questionType.toString());
                      }
                    },
                    separatorBuilder: (BuildContext context, int i) {
                      return const SizedBox(height: 2);
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                          strokeCap: StrokeCap.round));
                }
              },
            ))),
      ),
    );
  }
}

var worksheet = [
  ['Living and non-living things', 'EVS', 'Overdue', 'Teacher\'s Name'],
  ['Vowels and Noun', 'English', '3rd January', 'D. C. Pandey'],
  ['Fraction and Division', 'Maths', '19th January', 'H. C. Verma'],
  ['Name of worksheet', 'EVS', '22nd January', 'H. K. Das'],
];

class Lesson extends StatelessWidget {
  final String title;
  final String greenTxt;
  final String redTxt;
  final String blueTxt;

  const Lesson({
    super.key,
    required this.title,
    required this.greenTxt,
    required this.redTxt,
    required this.blueTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      width: DeviceType().isMobile ? 45.wp : 35.wp,
      height: DeviceType().isMobile ? 2.wp : 10.wp,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (DeviceType().isMobile ? 20 : 35).verticalSpacer,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            child: Text(
              title,
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
          (DeviceType().isMobile ? 0 : 15).verticalSpacer,
          //!EVS
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 1.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFF9CDDB6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              greenTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF074C2B),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          //!Overdue
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFC1B8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              redTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA94234),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          //!Teachers name
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFFB3EAFC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              blueTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF003A54),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          10.verticalSpacer,
          //!Solve
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 3.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFF8C7DF0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            child: Text(
              'Solve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: DeviceType().isMobile ? 18 : 24,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          // 15.verticalSpacer,
        ],
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
