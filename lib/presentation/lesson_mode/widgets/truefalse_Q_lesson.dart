import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../worksheet/models/questions.dart';
import '../../worksheet/widgets/question_text.dart';

class TrueOrFalseLesson extends StatefulWidget {
  final TrueFalseQuestion question;
  dynamic markedAnswer;
  TrueOrFalseLesson(
      {super.key, required this.question, required this.markedAnswer});

  @override
  State<TrueOrFalseLesson> createState() => _TrueOrFalseLessonState();
}

class _TrueOrFalseLessonState extends State<TrueOrFalseLesson> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QuestionText(question: widget.question.question),
        DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.wp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.markedAnswer = 'True';
                    setState(() {});
                    // context
                    //     .read<WorksheetSolverCubit>()
                    //     .setAnswer(questionIndex, 'True');
                  },
                  child: Container(
                    height: 80.h,
                    decoration: ShapeDecoration(
                      color: widget.markedAnswer == 'True'
                          ? const Color(0XFFB3EAFC)
                          : const Color(0xFFF4F2FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'True',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF4F3A9C),
                          fontSize: 120.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              8.horizontalSpacerPercent,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.markedAnswer = 'False';
                    setState(() {});
                    // context
                    //     .read<WorksheetSolverCubit>()
                    //     .setAnswer(questionIndex, 'False');
                  },
                  child: Container(
                    height: 80.h,
                    decoration: ShapeDecoration(
                      color: widget.markedAnswer == 'False'
                          ? const Color(0XFFB3EAFC)
                          : const Color(0xFFF4F2FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "False",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF4F3A9C),
                          fontSize: 120.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
