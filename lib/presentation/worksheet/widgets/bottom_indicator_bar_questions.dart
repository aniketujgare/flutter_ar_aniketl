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
            double size = 18.0;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.questions.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.currentQuestion) {
                  size = 18;
                  if (index != 0 && (index + 1) % 5 == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      child: CircleAvatar(
                        radius: size / 2,
                        child: Image.asset(
                          'assets/images/PNG Icons/coin.png',
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.submitGreenColor,
                      ),
                    ),
                  );
                }
                if (index == state.currentQuestion - 1 ||
                    index == state.currentQuestion + 1) {
                  size = 15;
                  if (index != 0 && (index + 1) % 5 == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.submitGreenColor,
                        ),
                        child: Image.asset(
                          'assets/images/PNG Icons/coin.png',
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFFE9E9E9),
                      ),
                    ),
                  );
                }
                if (index != 0 && (index + 1) % 5 == 0) {
                  size = 14;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.submitGreenColor,
                      ),
                      child: Image.asset('assets/images/PNG Icons/coin.png'),
                    ),
                  );
                } else {
                  size = 9;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFFE9E9E9),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
