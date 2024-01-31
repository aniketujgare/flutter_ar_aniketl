import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../../temp_testing/draw_test.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../models/questions.dart';
import '../widgets/appbar_worksheet_solver.dart';
import '../widgets/questions/fill_in_blank_question.dart';
import '../widgets/questions/mcq_image_question.dart';
import '../widgets/questions/mcq_text_question.dart';
import '../widgets/questions/true_or_false_question.dart';

class WorksheetSolverView extends StatefulWidget {
  final int workSheetId;
  final int studentId;
  const WorksheetSolverView(
      {super.key, required this.workSheetId, required this.studentId});

  @override
  State<WorksheetSolverView> createState() => _WorksheetSolverViewState();
}

class _WorksheetSolverViewState extends State<WorksheetSolverView>
    with TickerProviderStateMixin {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust the duration as needed
    );

    context.read<WorksheetSolverCubit>().setCurrentQuestionZero();
    context
        .read<WorksheetSolverCubit>()
        .init(widget.workSheetId, widget.studentId);
    print('workshetid: ${widget.workSheetId}, studentid: ${widget.studentId}');
  }

  List<Map<String, dynamic>> answers = [];

  Widget getQuestion(WorksheetSolverState state, int i) {
    dynamic markedAnswer = state.answerSheet
        .firstWhereOrNull(
          (element) => element.questionNo == i,
        )
        ?.question
        .answer
        .answer;
    if (markedAnswer != null) {
      print('markedAnswer: $i$markedAnswer');
    }
    switch (state.questions[i].questionType) {
      case QuestionType.mcqText:
        return MCQTextQuestion(
          questionIndex: i,
          question: state.questions[i] as McqTextQuestion,
          markedAnswer: markedAnswer,
        );
      case QuestionType.mcqImage:
        return MCQImageQuestion(
          questionIndex: i,
          question: state.questions[i] as McqImageQuestion,
          markedAnswer: markedAnswer,
        );
      case QuestionType.fillBlank:
        return FillInTheBlankQuestion(
          fillBlankQuestion: state.questions[i] as FillBlankQuestion,
          markedAnswer: markedAnswer,
          questionIndex: i,
        );

      case QuestionType.multiplefillblank:
        return Text('Multiple FillBlank not available');
      case QuestionType.trueFalse:
        return TrueOrFalseQuestion(
          questionIndex: i,
          question: state.questions[i] as TrueFalseQuestion,
          markedAnswer: markedAnswer,
        );

      case QuestionType.matchTheFollowing:
        MatchTheFollowingQuestion matchTheFollowingQuestion =
            state.questions[i] as MatchTheFollowingQuestion;
        var shuffledOptions = matchTheFollowingQuestion.options.entries.toList()
          ..shuffle();
        return _buildMatchTheFollowingQuestion(
            i, matchTheFollowingQuestion, shuffledOptions, markedAnswer);
      case QuestionType.oneWord:
        OneWordQuestion oneWordQuestion = state.questions[i] as OneWordQuestion;
        String? ans = markedAnswer;

        return GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapped outside the TextField
            // print('tapped outside textfield');
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DeviceType().isMobile ? 120.verticalSpacer : 160.verticalSpacer,
                Text(
                  oneWordQuestion.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 160.sp,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 70.wp,
                            height: 60,
                            child: Image.asset(
                              'assets/images/PNG Icons/Vector.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, 5.h),
                            child: Container(
                              width: 70.wp,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  // labelText: 'Type your answer',
                                  border: InputBorder.none,
                                ),
                                initialValue: ans,
                                onChanged: (value) {
                                  context
                                      .read<WorksheetSolverCubit>()
                                      .setAnswer(i, value);
                                },
                                onEditingComplete: () {
                                  print('complete');
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      5.horizontalSpacerPercent,
                      SizedBox(
                          width: 55,
                          child:
                              Image.asset('assets/images/PNG Icons/Cam 1.png'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case QuestionType.selectWord:
        SelectWordQuestion selectWordQuestion =
            state.questions[i] as SelectWordQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${selectWordQuestion.question}'),
            TextFormField(
              initialValue: (markedAnswer as String?) ?? '',
            ),
            const SizedBox(height: 10),
          ],
        );
      case QuestionType.oddOneOutText:
        OddOneOutTextQuestion oddOneOutTextQuestion =
            state.questions[i] as OddOneOutTextQuestion;
        return _buildOddOneOutTextQuestion(
            i, oddOneOutTextQuestion, markedAnswer);
      case QuestionType.oddOneOutimage:
        OddOneOutImageQuestion oddOneOutImageQuestion =
            state.questions[i] as OddOneOutImageQuestion;
        return _buildOddOneOutImageQuestion(
            i, oddOneOutImageQuestion, markedAnswer);
      case QuestionType.ascDescOrder:
        AscDescOrderQuestion ascDescOrderQuestion =
            state.questions[i] as AscDescOrderQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${ascDescOrderQuestion.question}'),
            Text(ascDescOrderQuestion.numbers.join(' ,')),
            TextFormField(
                initialValue: (markedAnswer as List<String>?) == null
                    ? ''
                    : (markedAnswer as List<String>).join(' ,')),
          ],
        );
      case QuestionType.arithmetic:
        return Text(state.questions[i].questionType.toString());
      case QuestionType.longAnswer:
        LongAnswerQuestion longAnswerQuestion =
            state.questions[i] as LongAnswerQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${longAnswerQuestion.question}'),
            Text(longAnswerQuestion.questionKeywords.join(', ')),
            TextFormField(initialValue: (markedAnswer as String?) ?? ''),
          ],
        );
      default:
        return const Center(
            child: CircularProgressIndicator.adaptive(
          strokeCap: StrokeCap.round,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: const Color(0XFFD1CBF9),
          appBar: appBarWorksheetSolver(context),
          body: SizedBox.expand(
              child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                ),
              ),
              BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
                builder: (context, state) {
                  if (state.status == WorkSheetSolverStatus.loaded) {
                    return getQuestion(state, state.currentQuestion);
                  } else {
                    return const Center(
                        child: CircularProgressIndicator.adaptive(
                            strokeCap: StrokeCap.round));
                  }
                },
              ),
              Transform.translate(
                offset: const Offset(-20, 0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      // controller.nextPage(
                      //     duration: const Duration(milliseconds: 300),
                      //     curve: Curves.linear);
                      context.read<WorksheetSolverCubit>().loadNextQuestion();
                    },
                    icon: RotatedBox(
                      quarterTurns: 2,
                      child: Image.asset(
                        'assets/ui/Group.png',
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 56,
                  child:
                      BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
                    builder: (context, state) {
                      double size = 18.0;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.questions.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.currentQuestion) {
                            size = 18;
                            if (index != 0 && (index + 1) % 5 == 0) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                child: CircleAvatar(
                                  radius: size / 2,
                                  child: Image.asset(
                                    'assets/images/PNG Icons/coin.png',
                                  ),
                                ),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.submitGreenColor,
                                ),
                              ),
                            );
                          }
                          if (index == state.currentQuestion - 1 ||
                              index == state.currentQuestion + 1) {
                            size = 15;
                            if (index != 0 && (index + 1) % 5 == 0) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  width: size,
                                  height: size,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.submitGreenColor,
                                  ),
                                  child: Image.asset(
                                    'assets/images/PNG Icons/coin.png',
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: Container(
                                width: size,
                                height: size,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0XFFE9E9E9),
                                ),
                              ),
                            );
                          }
                          if (index != 0 && (index + 1) % 5 == 0) {
                            size = 14;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.submitGreenColor,
                                ),
                                child: Image.asset(
                                    'assets/images/PNG Icons/coin.png'),
                              ),
                            );
                          } else {
                            size = 9;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: size,
                                height: size,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0XFFE9E9E9),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(20, 0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<WorksheetSolverCubit>()
                          .loadPreviousQuestion();
                    },
                    icon: Image.asset(
                      'assets/ui/Group.png',
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Column _buildOddOneOutImageQuestion(int i,
      OddOneOutImageQuestion oddOneOutImageQuestion, dynamic markedAnswer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${i + 1}) ${oddOneOutImageQuestion.question}'), // Display the question
        Column(
          children: List.generate(
            (oddOneOutImageQuestion.options.length / 2).ceil(),
            (rowIndex) {
              int startIndex = rowIndex * 2;
              int endIndex = startIndex + 2;
              endIndex = endIndex > oddOneOutImageQuestion.options.length
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
                          oddOneOutImageQuestion.options[optionIndex],
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                        ),
                        leading: Radio<bool>(
                          value: markedAnswer ==
                              oddOneOutImageQuestion.options[optionIndex],
                          groupValue:
                              true, // You need to set the group value accordingly
                          onChanged: (bool? value) {
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
  }

  Column _buildOddOneOutTextQuestion(int i,
      OddOneOutTextQuestion oddOneOutTextQuestion, dynamic markedAnswer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${i + 1}) ${oddOneOutTextQuestion.question}'), // Display the question
        Column(
          children: List.generate(
            (oddOneOutTextQuestion.options.length / 2).ceil(),
            (rowIndex) {
              int startIndex = rowIndex * 2;
              int endIndex = startIndex + 2;
              endIndex = endIndex > oddOneOutTextQuestion.options.length
                  ? oddOneOutTextQuestion.options.length
                  : endIndex;

              return Row(
                children: List.generate(
                  endIndex - startIndex,
                  (j) {
                    int optionIndex = startIndex + j;
                    return Expanded(
                      child: ListTile(
                        title: Text(oddOneOutTextQuestion.options[optionIndex]),
                        leading: Radio<bool>(
                          value: oddOneOutTextQuestion.options[optionIndex] ==
                                  markedAnswer
                              ? true
                              : false,
                          groupValue: true,
                          onChanged: null, // Set to null to disable interaction
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
  }

  Widget _buildMatchTheFollowingQuestion(
      int i,
      MatchTheFollowingQuestion matchTheFollowingQuestion,
      List<MapEntry<String, String>> shuffledOptions,
      dynamic markedAnswer) {
    return MatchTheFollowingTest(
      matchTheFollowingQuestion: matchTheFollowingQuestion,
      shuffledOptions: shuffledOptions,
      markedAnswer: markedAnswer,
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
