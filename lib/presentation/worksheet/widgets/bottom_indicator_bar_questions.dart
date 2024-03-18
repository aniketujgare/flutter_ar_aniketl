import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

class BottomIndicatorQuestions extends StatelessWidget {
  const BottomIndicatorQuestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: DeviceType().isMobile ? 56 : 80,
        child: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
          builder: (context, state) {
            if (state.status == WorkSheetSolverStatus.loading) {
              return const SizedBox();
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.questions.length,
              itemBuilder: (BuildContext context, int index) {
                return WormIndicator(
                  index: index,
                  currentQuestion: state.currentQuestion,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class WormIndicator extends StatelessWidget {
  final int index;
  final int currentQuestion;

  const WormIndicator({
    Key? key,
    required this.index,
    required this.currentQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size;
    if (index == currentQuestion) {
      size = 18;
    } else if (index == currentQuestion - 1 || index == currentQuestion + 1) {
      size = 15;
    } else if (index != 0 && (index + 1) % 5 == 0) {
      size = 14;
    } else {
      size = 9;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
          5,
          5,
          5,
          index == currentQuestion
              ? 9
              : index == currentQuestion - 1
                  ? 9
                  : index == currentQuestion + 1
                      ? 9
                      : 0),
      child: AnimatedContainer(
        width: size,
        height: size,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _pickColor(index, context),
        ),
        child: getCoin(index, size),
      ),
    );
  }

  Widget? getCoin(int index, double size) {
    if (index == currentQuestion) {
      if (index != 0 && (index + 1) % 5 == 0) {
        return Image.asset(
          'assets/images/PNG Icons/coin.png',
        );
      }
    }
    if (index == currentQuestion - 1 || index == currentQuestion + 1) {
      if (index != 0 && (index + 1) % 5 == 0) {
        return Image.asset(
          'assets/images/PNG Icons/coin.png',
        );
      }
    }
    if (index != 0 && (index + 1) % 5 == 0) {
      return Image.asset('assets/images/PNG Icons/coin.png');
    }
    return null;
  }

  Color _pickColor(int index, BuildContext context) {
    var worsheetBloc = context.read<WorksheetSolverCubit>().state;
    var answerAtIndex = worsheetBloc.answerSheet
        .firstWhereOrNull((element) => element.questionNo == index);
    // if (answerAtIndex != null) {
    //   answerAtIndex = answerAtIndex.question.answer.answer;
    // }

    // debugPrint(
    //     'worksheet index: $index ${jsonEncode(worsheetBloc.answerSheet)}');
    if (answerAtIndex != null && answerAtIndex.question.answer.answer != null) {
      return Colors.green;
    }
    // return Colors.green;
    // Check if the current index is greater than or equal to the number of answered questions
    // if (worsheetBloc.currentQuestion >= worsheetBloc.answerSheet.length) {
    //   // If so, return amber color for the current index
    //   if (index == worsheetBloc.currentQuestion) {
    //     return AppColors.accentColor;
    //   }
    // } else {
    //   // If the current index is less than the number of answered questions,
    //   // return submit green color if the current index is the marked answer
    //   if (index == worsheetBloc.currentQuestion &&
    //       worsheetBloc.answerSheet[index].question.answer.answer != null) {
    //     return AppColors.submitGreenColor;
    //   }
    // }

    // // If the current index is marked in the answer sheet, return submit green color
    // if (worsheetBloc.answerSheet.length > index &&
    //     worsheetBloc.answerSheet[index].question.answer.answer != null) {
    //   return AppColors.submitGreenColor;
    // }

    // // For every fifth index, return transparent color
    // if ((index + 1) % 5 == 0) {
    //   return Colors.transparent;
    // }

    // // For other cases, return the default color
    // return Colors.green;
    return const Color(0XFFE9E9E9);
  }
}
