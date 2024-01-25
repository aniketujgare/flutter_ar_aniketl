import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../models/questions.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

class MCQImageQuestion extends StatelessWidget {
  final int questionIndex;
  final McqImageQuestion question;
  final dynamic markedAnswer;
  const MCQImageQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${questionIndex + 1}) ${question.question}',
          style: TextStyle(
            color: const Color(0xFF212121),
            fontSize: 160.sp,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (question.options.length / 2).ceil(),
          itemBuilder: (BuildContext context, int rowIndex) {
            int startIndex = rowIndex * 2;
            int endIndex = (rowIndex + 1) * 2;
            endIndex = endIndex > question.options.length
                ? question.options.length
                : endIndex;

            return Row(
              children: List.generate(endIndex - startIndex, (j) {
                int optionIndex = startIndex + j;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('${optionIndex + 1}.'),
                        Container(
                          padding: (markedAnswer as String?) ==
                                  question.options[optionIndex]
                              ? const EdgeInsets.all(5)
                              : null,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber),
                          child: CachedNetworkImage(
                            imageUrl: question.options[optionIndex],
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
        TextFormField(
          initialValue: markedAnswer,
          onChanged: (value) {
            // newVal = value;
          },
          onEditingComplete: () {
            print('compelte');
            context
                .read<WorksheetSolverCubit>()
                .setAnswer(questionIndex, 'newVal');
          },
        ),
      ],
    );
  }
}
