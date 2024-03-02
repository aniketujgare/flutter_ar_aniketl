import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../worksheet/models/questions.dart';
import '../../worksheet/widgets/question_text.dart';

class MCQLesson extends StatefulWidget {
  final McqTextQuestion question;
  dynamic markedAnswer;
  MCQLesson({super.key, required this.question, required this.markedAnswer});

  @override
  State<MCQLesson> createState() => _MCQLessonState();
}

class _MCQLessonState extends State<MCQLesson> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionText(question: widget.question.question),
          DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.question.options.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.markedAnswer = index;
                      setState(() {});
                      debugPrint('ms: ${widget.markedAnswer}');

                      // context
                      //     .read<WorksheetSolverCubit>()
                      //     .setAnswer(questionIndex, question.options[index]);
                    },
                    child: Container(
                      height: 80.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.wp),
                      decoration: ShapeDecoration(
                        color: index == widget.markedAnswer
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
                            widget.question.options[index],
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
      ),
    );
  }
}
