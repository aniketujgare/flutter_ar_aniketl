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
  late bool isImg = false;
  @override
  void initState() {
    //?For images test
    // String imageUrl =
    //     "https://d3ag5oij4wsyi3.cloudfront.net/mcq_images/mysurroundings/Sun+in+sky.png";
    // for (var i = 0; i < 8; i++) {
    //   questionsList.add(imageUrl);
    // }

    questionsList.addAll(widget.question.category1Data);
    questionsList.addAll(widget.question.category2Data);
    questionsList.shuffle();
    isImg = questionsList.first.contains('http') ? true : false;
    //? Setting up size of box
    double halfEmptyBox = (questionsList.length - 1 + 2) / 2;
    int fullQuesBox = questionsList.length;
    singleBoxSize = widget.screenSize.width / (fullQuesBox + halfEmptyBox);
    debugPrint('singleBoxSize: $singleBoxSize');
    //?
    singleBoxSize = widget.screenSize.width * 0.14;
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              //! Category 1 Answers
              Expanded(
                flex: isImg ? 2 : 3,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(8.wp, 0, 4.wp, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.h)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          5.verticalSpacer,
                          Text(
                            widget.question.category1,
                            style: AppTextStyles.nunito160w500textCol
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          Container(
                            height: widget.screenSize.height * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.h)),
                            child: GridView.count(
                                crossAxisCount: isImg ? 3 : 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                childAspectRatio: isImg ? 1 : 2.1,
                                children: category1Answers.isEmpty
                                    ? [SizedBox(height: 70.h)]
                                    // :
                                    // questionsList[0].contains('http')
                                    //     ? generateSolutionChipImg(
                                    //         category1Answers)
                                    : List.generate(
                                        category1Answers.length,
                                        (index) => UnconstrainedBox(
                                          child: Container(
                                              height: 70.h,
                                              width: singleBoxSize,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 1.wp),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF4F2FE),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      )),
                          ),
                        ],
                      ),
                    );
                  },
                  onAccept: (data) {
                    debugPrint('$data Dropped successfully!');
                    category1Answers.add(data);
                    if (questionsList.contains(data)) {
                      questionsList.remove(data);
                      setState(() {});
                    }
                    // if (questionsList.isEmpty) {}
                    // context.read<WorksheetSolverCubit>().setAnswer(
                    //     widget.questionIndex,
                    //     List.from(category1Answers + category2Answers));
                  },
                ),
              ),
              //! Options Chips
              Expanded(
                flex: isImg ? 1 : 2,
                child: Container(
                  height: widget.screenSize.height * (isImg ? 0.7 : 0.6),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(22.h),
                  ),
                  child: GridView.count(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: isImg ? 1.2 : 1.7,
                    crossAxisCount: 2,
                    children: questionsList.isEmpty
                        ? [SizedBox(height: 70.h)]
                        // :
                        // questionsList[0].contains('http')
                        //     ? generateImgChips()
                        : generateTextChips(),
                  ),
                ),
              ),
              Expanded(
                  flex: isImg ? 2 : 3,
                  child: DragTarget<String>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(4.wp, 0, 8.wp, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.h)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            5.verticalSpacer,
                            Text(
                              widget.question.category2,
                              style: AppTextStyles.nunito160w500textCol
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                            Container(
                              height: widget.screenSize.height * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22.h)),
                              child: GridView.count(
                                  crossAxisCount: isImg ? 3 : 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: isImg ? 1 : 2.1,
                                  children: category2Answers.isEmpty
                                      ? [SizedBox(height: 70.h)]
                                      // :
                                      //  questionsList[0].contains('http')
                                      //     ? generateSolutionChipImg(
                                      // category2Answers)
                                      : List.generate(
                                          category2Answers.length,
                                          (index) => UnconstrainedBox(
                                            child: Container(
                                                height: 70.h,
                                                width: singleBoxSize,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.wp),
                                                decoration: ShapeDecoration(
                                                  color:
                                                      const Color(0xFFF4F2FE),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 65.h,
                                                  width: singleBoxSize,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      category2Answers[index],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF4F3A9C),
                                                        fontSize: 20,
                                                        fontFamily: 'Nunito',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )),
                            ),
                          ],
                        ),
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
                      // context.read<WorksheetSolverCubit>().setAnswer(
                      //     widget.questionIndex,
                      //     List.from(category1Answers + category2Answers));
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> generateSolutionChipImg(List<String> category) {
    return List.generate(
      category.length,
      (index) => UnconstrainedBox(
        child: Container(
            height: 110.h,
            width: 110.h,
            margin: EdgeInsets.symmetric(vertical: 1.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFFF4F2FE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: SizedBox(
              // height: 65.h,
              // width: singleBoxSize,
              child: Image.network(
                category[index],
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }

  List<Widget> generateSolutionChipTxt() {
    return List.generate(
      category1Answers.length,
      (index) => UnconstrainedBox(
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
      ),
    );
  }

  List<Widget> generateImgChips() {
    return List.generate(questionsList.length, (index) {
      return Draggable<String>(
        data: questionsList[index],
        feedback: Container(
          height: 150.h,
          width: 150.h,
          decoration: ShapeDecoration(
            color: const Color(0xFFF4F2FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          child: SizedBox(
            height: 75.h,
            width: 75.h,
            child: Image.network(
              questionsList[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        childWhenDragging: UnconstrainedBox(
          child: Container(
            height: 75.h,
            width: 75.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFF4F2FE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: SizedBox(
              height: 75.h,
              width: 75.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Image.network(
                  questionsList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        child: UnconstrainedBox(
          child: Container(
            height: 75.h,
            width: 75.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFF4F2FE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: SizedBox(
              height: 75.h,
              width: 75.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Image.network(
                  questionsList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> generateTextChips() {
    return List.generate(questionsList.length, (index) {
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
        child: UnconstrainedBox(
          child: Container(
            height: 70.h,
            width: 100,
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
        ),
      );
    });
  }
}
