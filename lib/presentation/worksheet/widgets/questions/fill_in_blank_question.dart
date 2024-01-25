import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

class FillInTheBlankQuestion extends StatelessWidget {
  final int questionIndex;
  final FillBlankQuestion question;
  final dynamic markedAnswer;

  const FillInTheBlankQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    List<String> markedAnswers = [];
    print('markedAnswer type: ${markedAnswer.runtimeType}');
    if (markedAnswer is List<dynamic>) {
      markedAnswers.addAll(markedAnswer.map((element) => element.toString()));
      print('listString');
    } else if (markedAnswer is String) {
      markedAnswers.add(markedAnswer);
      print('String');
    }

    print('markedAnswers: $questionIndex $markedAnswers');
    int noOfTextFileds = 1;
    if (question.answer is List<dynamic>) {
      noOfTextFileds = (question.answer as List<dynamic>).length;
    }
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside the TextField
        // print('tapped outside textfield');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            noOfTextFileds == 1 ? 120.verticalSpacer : 80.verticalSpacer,
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
            ...List.generate(
              noOfTextFileds,
              (j) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (noOfTextFileds != 1)
                      Text(
                        '${j + 1}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF4D4D4D),
                          fontSize: 24,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    5.horizontalSpacerPercent,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70.wp,
                          height: 60,
                          child: Image.asset(
                            'assets/images/PNG Icons/Vector.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -3.h),
                          child: Container(
                            width: 70.wp,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                // labelText: 'Type your answer',
                                border: InputBorder.none,
                              ),
                              initialValue: markedAnswers.length > j
                                  ? markedAnswers[j]
                                  : '',
                              onChanged: (value) {
                                if (markedAnswers.length > j) {
                                  markedAnswers[j] = value;
                                  context
                                      .read<WorksheetSolverCubit>()
                                      .setAnswer(questionIndex, markedAnswers);
                                } else {
                                  markedAnswers.add(value);
                                  context
                                      .read<WorksheetSolverCubit>()
                                      .setAnswer(questionIndex, markedAnswers);
                                }
                              },
                              onEditingComplete: () {
                                print('complete');
                                // context
                                //     .read<WorksheetSolverCubit>()
                                //     .setAnswer(i, markedAnswers);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.horizontalSpacerPercent,
                    SizedBox(
                        height: 55,
                        child: Image.asset('assets/images/PNG Icons/Cam 1.png'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
