import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../models/questions.dart';
import '../widgets/appbar_worksheet_solver.dart';
import '../widgets/bottom_indicator_bar_questions.dart';
import '../widgets/questions/ascending_decending_question.dart';
import '../widgets/questions/fill_in_blank_question.dart';
import '../widgets/questions/long_answer_question.dart';
import '../widgets/questions/match_the_following_question.dart';
import '../widgets/questions/mcq_image_question.dart';
import '../widgets/questions/mcq_text_question.dart';
import '../widgets/questions/odd_one_out_question.dart';
import '../widgets/questions/oneword_question.dart';
import '../widgets/questions/select_correct_word_question.dart';
import '../widgets/questions/sort_question.dart';
import '../widgets/questions/true_or_false_question.dart';

class WorksheetSolverView extends StatefulWidget {
  final int workSheetId;
  const WorksheetSolverView({super.key, required this.workSheetId});

  @override
  State<WorksheetSolverView> createState() => _WorksheetSolverViewState();
}

class _WorksheetSolverViewState extends State<WorksheetSolverView> {
  @override
  void initState() {
    super.initState();

    context.read<WorksheetSolverCubit>().setCurrentQuestionZero();
    context.read<WorksheetSolverCubit>().init(widget.workSheetId);
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
        Size screenSize = MediaQuery.of(context).size;
        return MCQImageQuestion(
            questionIndex: i,
            question: state.questions[i] as McqImageQuestion,
            markedAnswer: markedAnswer,
            screenSize: screenSize);
      case QuestionType.fillBlank:
        Size screenSize = MediaQuery.of(context).size;

        // var qty = SortingQuestionType(
        //   category1Data: ["ant", "cat", "dog"],
        //   category2Data: ["bat", "ball", "mat"],
        //   category1: "living",
        //   category2: "non-living",
        //   question: "sort foolowing",
        // );
        // return SortQuestion(
        //     question: qty,
        //     markedAnswer: null,
        //     questionIndex: i,
        //     screenSize: screenSize);
        return FillInTheBlankQuestion(
            question: state.questions[i] as FillBlankQuestion,
            markedAnswer: markedAnswer,
            questionIndex: i,
            screenSize: screenSize);

      case QuestionType.multiplefillblank:
        return const Text('Multiple FillBlank not available');
      case QuestionType.trueFalse:
        return TrueOrFalseQuestion(
          questionIndex: i,
          question: state.questions[i] as TrueFalseQuestion,
          markedAnswer: markedAnswer,
        );

      case QuestionType.matchTheFollowing:
        Size screenSize = MediaQuery.of(context).size;
        return MatchFollowingQuestion(
          question: state.questions[i] as MatchTheFollowingQuestion,
          markedAnswer: markedAnswer,
          screenSize: screenSize,
        );
      case QuestionType.oneWord:
        Size screenSize = MediaQuery.of(context).size;
        // String? ans = markedAnswer;

        return OneWordQuestion(
            questionIndex: i,
            context: context,
            oneWordQuestion: state.questions[i] as OneWordQuestionType,
            markedAnswer: markedAnswer,
            screenSize: screenSize);
      case QuestionType.selectWord:
        return SelectCorrectWordQuestion(
          questionIndex: i,
          question: state.questions[i] as SelectWordQuestion,
          markedAnswer: markedAnswer,
        );
      case QuestionType.oddOneOutText:
        return OddOneOutQuestion(
          questionIndex: i,
          question: state.questions[i] as OddOneOutTextQuestion,
          markedAnswer: markedAnswer,
        );

      case QuestionType.oddOneOutimage:
        OddOneOutImageQuestion oddOneOutImageQuestion =
            state.questions[i] as OddOneOutImageQuestion;
        return _buildOddOneOutImageQuestion(
            i, oddOneOutImageQuestion, markedAnswer);
      case QuestionType.ascDescOrder:
        // String questionn =
        //     "This method also of type allows for easier not any shuffling of just array,";
        // String answerr =
        //     "This method also allows for easier shuffling of any type of array, not just";
        // var newQ = RearrangeQuestionType(answer: answerr, question: questionn);
        // return ReArrangeWordsQuestion(
        //   question: newQ as RearrangeQuestionType,
        //   markedAnswer: markedAnswer,
        //   questionIndex: i,
        // );
        // var newQII = IdentifyImageQuestionType(
        //     answer: 'zoro',
        //     question:
        //         'https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/1/worksheet/850/ii_mcq/4wfdhskzr/0.png');
        // return IdentifyImageQuestion(
        //   questionIndex: i,
        //   question: newQII,
        //   markedAnswer: markedAnswer,
        // );
        Size screenSize = MediaQuery.of(context).size;

        return AscendingDecendingQuestion(
            questionIndex: i,
            question: state.questions[i] as AscDescOrderQuestion,
            markedAnswer: markedAnswer,
            screenSize: screenSize);
      case QuestionType.arithmetic:
        return Text(state.questions[i].questionType.toString());
      case QuestionType.longAnswer:
        Size screenSize = MediaQuery.of(context).size;
        return LongAnswerQuestion(
            questionIndex: i,
            question: state.questions[i] as LongAnswerQuestionType,
            markedAnswer: markedAnswer,
            screenSize: screenSize);
      default:
        return Text(
            'UI for ${state.questions[i].questionType.toString()} doesn\'t exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: DeviceType().isMobile ? 56 : 80,
          width: double.infinity,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.wp),
                child: IconButton(
                  onPressed: () {
                    context.read<WorksheetSolverCubit>().loadPreviousQuestion();
                  },
                  icon: Image.asset(
                    'assets/ui/Group.png',
                    height: 40,
                  ),
                ),
              ),
              const BottomIndicatorQuestions(),
              Padding(
                padding: EdgeInsets.only(right: 8.wp),
                child: IconButton(
                  onPressed: () {
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
            ],
          ),
        ),
        backgroundColor: const Color(0XFFD1CBF9),
        appBar: appBarWorksheetSolver(context),
        body: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
          builder: (context, state) {
            if (state.status == WorkSheetSolverStatus.loaded) {
              if (state.questions.isEmpty) {
                return Center(
                  child: Text(
                    'No questions are available in the worksheet at the moment.',
                    style: AppTextStyles.nunito105w700Text,
                  ),
                );
              }
              return getQuestion(state, state.currentQuestion);
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  strokeCap: StrokeCap.round,
                ),
              );
            }
          },
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
