import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class OddOneOutQuestion extends StatelessWidget {
  final int questionIndex;
  final OddOneOutTextQuestion question;
  final dynamic markedAnswer;
  const OddOneOutQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QuestionText(question: question.question),
        DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.wp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              question.options.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<WorksheetSolverCubit>()
                        .setAnswer(questionIndex, question.options[index]);
                  },
                  child: Container(
                    height: 80.h,
                    margin: EdgeInsets.symmetric(horizontal: 2.wp),
                    decoration: ShapeDecoration(
                      color: question.options[index] == markedAnswer
                          ? AppColors.boxSelectedColor
                          : AppColors.boxUnselectedolor,
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
                          question.options[index],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF4F3A9C),
                            fontSize: 120.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
