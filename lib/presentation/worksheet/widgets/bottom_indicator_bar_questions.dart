import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        height: 56,
        child: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
          builder: (context, state) {
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
              ? 18
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
          color: _pickColor(index),
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

  Color _pickColor(int index) {
    if (index == currentQuestion) {
      if ((index + 1) % 5 == 0) return Colors.transparent;
      return AppColors.submitGreenColor;
    }
    if ((index + 1) % 5 == 0) {
      return Colors.transparent;
    }
    return const Color(0XFFE9E9E9);
  }
}
