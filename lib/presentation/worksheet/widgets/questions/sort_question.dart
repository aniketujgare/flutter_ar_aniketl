import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class SortQuestion extends StatefulWidget {
  final int questionIndex;
  final SortingQuestionType question;
  final List<String>? markedAnswer;
  final Size screenSize;
  const SortQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer,
      required this.screenSize});

  @override
  State<SortQuestion> createState() => _SortQuestionState();
}

class _SortQuestionState extends State<SortQuestion> {
  List<String> questionsList = [];
  List<String> category1Answers = [];
  List<String> category2Answers = [];
  late double singleBoxSize;
  @override
  void initState() {
    questionsList.addAll(widget.question.category1Data);
    questionsList.addAll(widget.question.category2Data);
    questionsList.shuffle();

    //? Setting up size of box
    double halfEmptyBox = (questionsList.length - 1 + 2) / 2;
    int fullQuesBox = questionsList.length;
    singleBoxSize = widget.screenSize.width / (fullQuesBox + halfEmptyBox);
    debugPrint('singleBoxSize: $singleBoxSize');
    //?

    if (widget.markedAnswer != null &&
        widget.markedAnswer!.length == questionsList.length)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < widget.markedAnswer!.length; i++) {
        if (widget.markedAnswer![i] != ' ') {
          // isDraggedList[i] = true;
          // selectedAnswer[i] = widget.markedAnswer![i];
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionText(question: widget.question.question),
          DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          // padding: EdgeInsets.symmetric(vertical: 2.wp),
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
          50.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.wp),
            child: Row(
              children: [
                //! Category 1 Ans Box
                Expanded(
                    child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: widget.screenSize.height * 0.4,
                      color: Colors.amber,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: category1Answers.length,
                          padding: EdgeInsets.only(top: 10.h),
                          itemBuilder: (context, index) {
                            return UnconstrainedBox(
                              child: Container(
                                  height: 70.h,
                                  width: singleBoxSize,
                                  margin: EdgeInsets.symmetric(vertical: 1.wp),
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
                                        category1Answers[index],
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
                          }),
                    );
                  },
                  onAccept: (data) {
                    debugPrint('$data Dropped successfully!');
                    category1Answers.add(data);
                    if (questionsList.contains(data)) {
                      questionsList.remove(data);
                      setState(() {});
                    }
                    if (questionsList.isEmpty) {}
                    context.read<WorksheetSolverCubit>().setAnswer(
                        widget.questionIndex,
                        List.from(category1Answers + category2Answers));
                  },
                )),
                10.horizontalSpacerPercent,

                //! Category 2 Ans Box
                Expanded(
                    child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: widget.screenSize.height * 0.4,
                      color: Colors.red,
                      child: ListView.builder(
                          itemCount: category2Answers.length,
                          padding: EdgeInsets.only(top: 10.h),
                          itemBuilder: (context, index) {
                            return UnconstrainedBox(
                              child: Container(
                                  key: const Key('ascDesChild'),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.wp),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        category2Answers[index],
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
                          }),
                    );
                  },
                  onAccept: (data) {
                    debugPrint('$data Dropped successfully!');
                    category2Answers.add(data);
                    if (questionsList.contains(data)) {
                      questionsList.remove(data);
                      setState(() {});
                    }
                    if (questionsList.isEmpty) {}
                    context.read<WorksheetSolverCubit>().setAnswer(
                        widget.questionIndex,
                        List.from(category1Answers + category2Answers));
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
