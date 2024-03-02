import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class AscendingDecendingQuestion extends StatefulWidget {
  final int questionIndex;
  final AscDescOrderQuestion question;
  final List<String>? markedAnswer;
  final Size screenSize;
  const AscendingDecendingQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer,
      required this.screenSize});

  @override
  State<AscendingDecendingQuestion> createState() =>
      _AscendingDecendingQuestionState();
}

class _AscendingDecendingQuestionState
    extends State<AscendingDecendingQuestion> {
  List<bool> isDraggedList = [];
  List<String> selectedAnswer = [];
  late double singleBoxSize;
  @override
  void initState() {
    debugPrint('marked answers: ${widget.markedAnswer}');
    for (var v in widget.question.numbers) {
      isDraggedList.add(false);
      selectedAnswer.add(' ');
    }
    if (widget.markedAnswer != null &&
        widget.markedAnswer!.length == widget.question.numbers.length)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < widget.markedAnswer!.length; i++) {
        if (widget.markedAnswer![i] != ' ') {
          isDraggedList[i] = true;
          selectedAnswer[i] = widget.markedAnswer![i];
        }
      }
    //? Setting up box sixe
    double halfEmptyBox = (widget.question.numbers.length - 1 + 2) / 2;
    int fullQuesBox = widget.question.numbers.length;
    singleBoxSize = widget.screenSize.width / (fullQuesBox + halfEmptyBox);
    //?
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
              children: List.generate(widget.question.numbers.length, (index) {
                for (var i = 0; i < selectedAnswer.length; i++) {
                  if (selectedAnswer.contains(widget.question.numbers[index])) {
                    return SizedBox(
                      height: 65.h,
                      width: singleBoxSize,
                    );
                  }
                }
                return Draggable<String>(
                  data: widget.question.numbers[index],
                  feedback: Container(
                    height: 65.h,
                    width: singleBoxSize,
                    // margin: EdgeInsets.symmetric(horizontal: 2.wp),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F2FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Container(
                      height: 65.h,
                      width: singleBoxSize,
                      // margin: EdgeInsets.symmetric(horizontal: 2.wp),
                      // padding: EdgeInsets.symmetric(horizontal: 1.wp),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.question.numbers[index],
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
                    height: 65.h,
                    width: singleBoxSize,
                    // padding: EdgeInsets.symmetric(vertical: 2.wp),
                    decoration: ShapeDecoration(
                      color: AppColors.hintTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.question.numbers[index],
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
                    height: 65.h,
                    width: singleBoxSize,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F2FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: SizedBox(
                      height: 65.h,
                      width: singleBoxSize,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.question.numbers[index],
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
          50.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.question.numbers.length,
                (index) {
                  return Expanded(
                    child: DragTarget<String>(
                      onAccept: (data) {
                        debugPrint('$data Dropped successfully!');
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
