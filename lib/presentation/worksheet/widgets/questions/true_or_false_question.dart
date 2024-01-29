import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class TrueOrFalseQuestion extends StatelessWidget {
  final int questionIndex;
  final TrueFalseQuestion question;
  final dynamic markedAnswer;
  const TrueOrFalseQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DeviceType().isMobile ? 120.verticalSpacer : 160.verticalSpacer,
        QuestionText(question: question.question),
        DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.wp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<WorksheetSolverCubit>()
                        .setAnswer(questionIndex, 'True');
                  },
                  child: Container(
                    height: 90.h,
                    decoration: ShapeDecoration(
                      color: markedAnswer == 'True'
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
              5.horizontalSpacerPercent,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<WorksheetSolverCubit>()
                        .setAnswer(questionIndex, 'False');
                  },
                  child: Container(
                    height: 90.h,
                    decoration: ShapeDecoration(
                      color: markedAnswer == 'False'
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
