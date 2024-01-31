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
  final McqTextQuestion question;
  final dynamic markedAnswer;
  const SelectCorrectWordQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    // //!select the correct word  q ui
    List<String> otions = ['This', 'is', 'the', 'test', 'question', 'sentence'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        80.verticalSpacer,
        Text(
          'This is the test question sentence.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF212121),
            fontSize: 32,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        80.verticalSpacer,
        // Text('${i + 1}) ${mcqTextQuestion.question}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
                6,
                (index) => Container(
                      width: 30.wp,
                      padding: EdgeInsets.symmetric(vertical: 2.wp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F2FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Text(
                        otions[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF4F3A9C),
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ))
          ],
        ),
      ],
    );
  }
}
