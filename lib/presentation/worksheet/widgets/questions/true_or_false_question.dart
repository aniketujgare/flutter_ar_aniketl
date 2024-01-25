import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

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
        80.verticalSpacer,
        Text(
          question.question,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF212121),
            fontSize: 160.sp,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        80.verticalSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context
                    .read<WorksheetSolverCubit>()
                    .setAnswer(questionIndex, 'True');
              },
              child: Container(
                width: 60.wp,
                padding: EdgeInsets.symmetric(vertical: 3.wp),
                decoration: ShapeDecoration(
                  color: markedAnswer == 'True'
                      ? const Color(0XFFB3EAFC)
                      : const Color(0xFFF4F2FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
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
            10.horizontalSpacerPercent,
            GestureDetector(
              onTap: () {
                context
                    .read<WorksheetSolverCubit>()
                    .setAnswer(questionIndex, 'False');
              },
              child: Container(
                width: 60.wp,
                padding: EdgeInsets.symmetric(vertical: 3.wp),
                decoration: ShapeDecoration(
                  color: markedAnswer == 'False'
                      ? const Color(0XFFB3EAFC)
                      : const Color(0xFFF4F2FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
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
          ],
        ),
      ],
    );
  }
}
