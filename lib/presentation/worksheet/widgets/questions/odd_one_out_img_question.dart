import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class OddOneOutImgQuestion extends StatelessWidget {
  final int questionIndex;
  final OddOneOutImageQuestion question;
  final dynamic markedAnswer;
  final Size screenSize;
  const OddOneOutImgQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer,
      required this.screenSize});

  @override
  Widget build(BuildContext context) {
    double halfEmptyBox = (question.options.length - 1 + 2) / 2;
    int fullQuesBox = question.options.length;
    double singleBoxSize = screenSize.width / (fullQuesBox + halfEmptyBox);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QuestionText(question: question.question),
        DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.wp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              question.options.length,
              (index) => GestureDetector(
                onTap: () {
                  context
                      .read<WorksheetSolverCubit>()
                      .setAnswer(questionIndex, question.options[index]);
                },
                child: Container(
                  height: singleBoxSize,
                  width: singleBoxSize,
                  decoration: ShapeDecoration(
                    color: question.options[index] == markedAnswer
                        ? AppColors.boxSelectedColor
                        : AppColors.boxUnselectedolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: question.options[index],
                    fit: BoxFit.scaleDown,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator.adaptive(
                          strokeCap: StrokeCap.round),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
