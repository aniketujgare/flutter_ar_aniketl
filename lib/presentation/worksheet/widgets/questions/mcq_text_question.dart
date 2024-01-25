import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

class MCQTextQuestion extends StatelessWidget {
  final int questionIndex;
  final McqTextQuestion question;
  final dynamic markedAnswer;
  const MCQTextQuestion(
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
        120.verticalSpacer,
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
        55.verticalSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
              question.options.length,
              (index) => GestureDetector(
                onTap: () {
                  context
                      .read<WorksheetSolverCubit>()
                      .setAnswer(questionIndex, question.options[index]);
                },
                child: Container(
                  width: 40.wp,
                  padding: EdgeInsets.symmetric(vertical: 3.wp),
                  decoration: ShapeDecoration(
                    color: question.options[index] == markedAnswer
                        ? const Color(0xFFB3EAFC)
                        : const Color(0xFFF4F2FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Text(
                    question.options[index],
                    overflow: TextOverflow.ellipsis,
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
            )
          ],
        ),
      ],
    );
  }
}
