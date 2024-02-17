import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

class OneWordQuestion extends StatelessWidget {
  const OneWordQuestion({
    super.key,
    required this.context,
    required this.oneWordQuestion,
    required this.markedAnswer,
    required this.questionIndex,
    required this.screenSize,
  });
  final int questionIndex;
  final BuildContext context;
  final OneWordQuestionType oneWordQuestion;
  final dynamic markedAnswer;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside the TextField
        // print('tapped outside textfield');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DeviceType().isMobile
                ? 120.verticalSpacer
                : (screenSize.height * 0.25).verticalSpacer,
            Text(
              oneWordQuestion.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF212121),
                fontSize: 160.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
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
                        offset: Offset(0, 5.h),
                        child: Container(
                          width: 70.wp,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // labelText: 'Type your answer',
                              border: InputBorder.none,
                            ),
                            initialValue: markedAnswer,
                            onChanged: (value) {
                              context
                                  .read<WorksheetSolverCubit>()
                                  .setAnswer(questionIndex, value);
                            },
                            onEditingComplete: () {
                              print('complete');
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.horizontalSpacerPercent,
                  SizedBox(
                      width: 55,
                      child: Image.asset('assets/images/PNG Icons/Cam 1.png'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
