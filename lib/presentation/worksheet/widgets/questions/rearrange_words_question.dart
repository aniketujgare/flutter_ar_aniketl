import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class ReArrangeWordsQuestion extends StatefulWidget {
  final int questionIndex;
  final RearrangeQuestionType question;
  final dynamic markedAnswer;
  final Size screenSize;
  const ReArrangeWordsQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer,
      required this.screenSize});

  @override
  State<ReArrangeWordsQuestion> createState() => _ReArrangeWordsQuestionState();
}

class _ReArrangeWordsQuestionState extends State<ReArrangeWordsQuestion> {
  List<String> questionsList = [];
  List<String> studentAnswersList = [];
  late int questionsLength;
  late double singleBoxSize;
  @override
  void initState() {
    questionsList.addAll(widget.question.question.trim().split(' '));
    //remove empty strings or spaces case: 'I'd Nah  Win
    questionsList.removeWhere((element) => element == '');
    questionsList.shuffle();
    questionsLength = questionsList.length;
    //? Setting up size of box
    double halfEmptyBox = (questionsList.length - 1 + 2) / 2;
    int fullQuesBox = questionsList.length;
    singleBoxSize =
        widget.screenSize.width / (fullQuesBox + (halfEmptyBox / 2));
    debugPrint('singleBoxSize: $singleBoxSize');
    //?
    for (var _ in questionsList) {
      studentAnswersList.add(' ');
    }
    //? Fill marked answers
    if (widget.markedAnswer != null && widget.markedAnswer.isNotEmpty) {
      for (var i = 0; i < widget.markedAnswer.length; i++) {
        studentAnswersList[i] = widget.markedAnswer[i];
      }
    }

    for (var option in studentAnswersList) {
      var optionFound =
          questionsList.firstWhereOrNull((element) => element == option);
      if (optionFound != null) {
        int idx = questionsList.indexWhere((element) => element == optionFound);
        questionsList[idx] = '!remove!';
      }
    }
    questionsList.removeWhere((element) => element == '!remove!');

    print('Re arrange student ans list: ${widget.question.question}');
    if (studentAnswersList.length == questionsLength &&
        !studentAnswersList.contains(' ')) {
      questionsList.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionText(question: widget.question.question),
          DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceType().isMobile ? 10.wp : 5.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: questionsList.isEmpty
                  ? [SizedBox(height: 70.h)]
                  : List.generate(questionsList.length, (index) {
                      return Draggable<String>(
                        data: questionsList[index],
                        feedback: Container(
                          height: 70.h,
                          width: singleBoxSize,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF4F2FE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: SizedBox(
                            height: 70.h,
                            width: singleBoxSize,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                questionsList[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF4F3A9C),
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          height: 70.h,
                          width: singleBoxSize,
                          margin: EdgeInsets.symmetric(horizontal: 2.wp),
                          decoration: ShapeDecoration(
                            color: AppColors.hintTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              questionsList[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF4F3A9C),
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          height: 70.h,
                          width: singleBoxSize,
                          margin: EdgeInsets.symmetric(horizontal: 2.wp),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF4F2FE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: SizedBox(
                            height: 70.h,
                            width: singleBoxSize,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                questionsList[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF4F3A9C),
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
            ),
          ),
          30.verticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                questionsLength,
                (index) => DragTarget<String>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return UnconstrainedBox(
                          child: Container(
                              height: 70.h,
                              margin: EdgeInsets.symmetric(vertical: 1.wp),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF4F2FE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                              child: Container(
                                height: 70.h,
                                width: singleBoxSize,
                                padding: EdgeInsets.symmetric(horizontal: 1.wp),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    studentAnswersList[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF4F3A9C),
                                      fontSize: 20,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )),
                        );
                      },
                      onAccept: (data) {
                        debugPrint('$data Dropped successfully!');
                        if (studentAnswersList[index] != ' ') {
                          questionsList.add(studentAnswersList[index]);
                        }
                        if (questionsList.contains(data)) {
                          questionsList.remove(data);
                          setState(() {});
                        }

                        studentAnswersList[index] = data;
                        if (studentAnswersList.length == questionsLength) {
                          print('answer Submitted');
                          context.read<WorksheetSolverCubit>().setAnswer(
                              widget.questionIndex, [...studentAnswersList]);
                        }
                      },
                    )),
          )
        ],
      ),
    );
  }
}
