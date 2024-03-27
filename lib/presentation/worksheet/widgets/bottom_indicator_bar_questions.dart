import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/device_type.dart';
import '../bloc/bottom_indicator_cubit/bottom_indicator_cubit.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

class BottomIndicatorQuestions extends StatefulWidget {
  const BottomIndicatorQuestions({
    super.key,
  });

  @override
  State<BottomIndicatorQuestions> createState() =>
      _BottomIndicatorQuestionsState();
}

class _BottomIndicatorQuestionsState extends State<BottomIndicatorQuestions> {
  ScrollController sc = ScrollController();

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomIndicatorCubit, BottomIndicatorState>(
      listener: (context, state) {
        state.map(
            animate: (an) {
              var cubit = context.read<WorksheetSolverCubit>().state;
              context
                  .read<BottomIndicatorCubit>()
                  .scrollBottomIndicatorPosition(
                      cubit.currentQuestion,
                      cubit.questions.length,
                      sc,
                      MediaQuery.of(context).size.width);
            },
            initial: (an) {},
            shouldTransit: (an) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                sc.animateTo(an.animateOffse,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              });
            });
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            height: DeviceType().isMobile ? 56 : 80,
            child: ListView(
              controller: sc,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ...List.generate(
                    context.read<WorksheetSolverCubit>().state.questions.length,
                    (index) => WormIndicator(
                          index: index,
                          currentQuestion: context
                              .read<WorksheetSolverCubit>()
                              .state
                              .currentQuestion,
                        ))
              ],
            )),
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
      size = 13;
    } else if (index != 0 && (index + 1) % 5 == 0) {
      size = 12;
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
        child: getCoin(index, size, context),
      ),
    );
  }

  Widget? getCoin(int index, double size, BuildContext context) {
    if (context
            .read<WorksheetSolverCubit>()
            .state
            .answerSheet[index]
            .question
            .answer
            .answer !=
        null) {
      return null;
    }
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
    if (answerAtIndex != null && answerAtIndex.question.answer.answer != null) {
      return Colors.green;
    }
    return const Color(0XFFE9E9E9);
  }
}
