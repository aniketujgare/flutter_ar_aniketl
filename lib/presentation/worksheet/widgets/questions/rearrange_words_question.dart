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
  final List<String>? markedAnswer;
  const ReArrangeWordsQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  State<ReArrangeWordsQuestion> createState() =>
      _AscendingDecendingQuestionState();
}

class _AscendingDecendingQuestionState extends State<ReArrangeWordsQuestion> {
  List<bool> isDraggedList = [];
  List<String> selectedAnswer = [];
  List<String> questinWords = [];
  @override
  void initState() {
    questinWords.addAll(widget.question.question.split(' '));
    print('marked answers: ${widget.markedAnswer}');
    for (var v in questinWords) {
      isDraggedList.add(false);
      selectedAnswer.add(' ');
    }
    if (widget.markedAnswer != null &&
        widget.markedAnswer!.length == questinWords.length)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < widget.markedAnswer!.length; i++) {
        if (widget.markedAnswer![i] != ' ') {
          isDraggedList[i] = true;
          selectedAnswer[i] = widget.markedAnswer![i];
        }
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
            padding: EdgeInsets.symmetric(horizontal: 20.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(questinWords.length, (index) {
                for (var i = 0; i < selectedAnswer.length; i++) {
                  if (selectedAnswer.contains(questinWords[index])) {
                    return Expanded(
                      child: SizedBox(
                        height: 65.h,
                        width: 30.wp,
                      ),
                    );
                  }
                }
                return Expanded(
                  child: Draggable<String>(
                    data: questinWords[index],
                    feedback: Container(
                      height: 65.h,
                      width: 30.wp,
                      margin: EdgeInsets.symmetric(horizontal: 2.wp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F2FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.wp),
                        padding: EdgeInsets.symmetric(horizontal: 1.wp),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ' questinWords[index]',
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
                      width: 30.wp,
                      padding: EdgeInsets.symmetric(vertical: 2.wp),
                      decoration: ShapeDecoration(
                        color: AppColors.hintTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Text(
                        questinWords[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF4F3A9C),
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    child: Container(
                      key: const Key('ascDesChild'),
                      height: 65.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.wp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F2FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.wp),
                        padding: EdgeInsets.symmetric(horizontal: 1.wp),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            questinWords[index],
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
                  ),
                );
              }),
            ),
          ),
          50.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                questinWords.length,
                (index) {
                  // int idx = selectedAnswer.indexWhere(
                  //     (element) => widget.question.numbers[index] == element);
                  // if (idx != -1) {
                  //   selectedAnswer[idx] = ' ';
                  //   isDraggedList[index] = false;
                  // }
                  return Expanded(
                    child: DragTarget<String>(
                      onWillAccept: (data) {
                        if (selectedAnswer.contains(data)) {
                          for (int i = 0; i < selectedAnswer.length; i++) {
                            if (selectedAnswer[i] == data) {
                              selectedAnswer[i] = ' ';
                              isDraggedList[i] = false;
                            }
                          }
                        }

                        isDraggedList[index] = true;
                        selectedAnswer[index] = data ?? ' ';
                        if (!selectedAnswer.contains(' ')) {}
                        context
                            .read<WorksheetSolverCubit>()
                            .setAnswer(widget.questionIndex, selectedAnswer);

                        return data == 'red';
                      },
                      onAccept: (data) {
                        print('selected answers: $selectedAnswer');
                        print('Dropped successfully!');
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Dropped successfully!')));
                      },
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
                          height: 70.h,
                          margin: EdgeInsets.symmetric(horizontal: 2.wp),
                          decoration: ShapeDecoration(
                            color: isDraggedList[index] == true
                                ? AppColors.primaryColor
                                : const Color(0xFFF4F2FE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.wp),
                            padding: EdgeInsets.symmetric(horizontal: 1.wp),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                selectedAnswer[index],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFFF4F2FE),
                                  fontSize: 120.sp,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}