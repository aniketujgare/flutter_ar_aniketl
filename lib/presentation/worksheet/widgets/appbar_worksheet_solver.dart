import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

AppBar appBarWorksheetSolver(BuildContext context) {
  return AppBar(
    toolbarHeight: DeviceType().isMobile ? 56 : 80,
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0XFF4F3A9C),
    leading: null,
    title: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
            height: 36.h,
            width: 36.h,
            child: Image.asset(
              'assets/images/reusable_icons/back_button_primary.png',
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
          builder: (context, state) {
            if (state.status == WorkSheetSolverStatus.loaded) {
              return Text(
                // 'Q1. Fill in the Blanks',
                'Q.${state.currentQuestion + 1} ${state.questions[state.currentQuestion].getQuestionTypeString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 136.sp,
                  fontFamily: 'Uniform Rounded',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            context.read<WorksheetSolverCubit>().answerSubmit();
            Navigator.of(context).pop();
          },
          child: Container(
            width: 70,
            height: 40,
            // padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 28),
            decoration: ShapeDecoration(
              color: const Color(0xFF45C375),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: const Center(
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
