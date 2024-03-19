import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class SelectCorrectWordQuestion extends StatelessWidget {
  final int questionIndex;
  final SelectWordQuestion question;
  final dynamic markedAnswer;
  const SelectCorrectWordQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    // //!select the correct word  q ui
    List<String> optionsList = question.question.trim().split(' ');
    // optionsList.shuffle();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QuestionText(question: question.question),
        DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
                optionsList.length,
                (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<WorksheetSolverCubit>()
                              .setAnswer(questionIndex, optionsList[index]);
                        },
                        child: Container(
                          height: 80.h,
                          margin: EdgeInsets.symmetric(horizontal: 2.wp),
                          decoration: ShapeDecoration(
                            color: optionsList[index] == markedAnswer
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
                                optionsList[index],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.nunito120w700primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
          ],
        ),
      ],
    );
  }
}
