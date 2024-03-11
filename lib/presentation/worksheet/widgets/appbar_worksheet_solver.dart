import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/worksheet/bloc/question_timer_cubit/question_timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import 'worksheet_submitted_box.dart';

AppBar appBarWorksheetSolver(BuildContext context) {
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const Dialog(
          child: WorksheetSubmittedBox(),
        );
      },
    );
  }

  return AppBar(
    titleSpacing: 0.0,
    centerTitle: true,
    leadingWidth: 125.h,
    toolbarHeight: DeviceType().isMobile ? null : 80.h,
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primaryColor,
    leading: GestureDetector(
      onTap: () {
        context.read<QuestionTimerCubit>().stopTime();
        Navigator.pop(context);
      },
      child: UnconstrainedBox(
        child: Image.asset(
          'assets/images/reusable_icons/back_button_primary.png',
          color: Colors.white,
          height: 50.h,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 50.h),
        child: BlocBuilder<QuestionTimerCubit, QuestionTimerState>(
          builder: (context, state) {
            if (state.status == QuestionTimerStatus.progressing ||
                state.status == QuestionTimerStatus.end) {
              return Text('Time: ${state.currentTime} sec',
                  style: DeviceType().isMobile
                      ? AppTextStyles.uniformRounded136BoldAppBarStyle.copyWith(
                          color: state.currentTime <= 10
                              ? AppColors.redMessageSharedFileContainerColor
                              : Colors.white)
                      : AppTextStyles.uniformRounded136BoldAppBarStyle.copyWith(
                          fontSize: 136.sp * 0.7,
                          color: state.currentTime <= 10
                              ? AppColors.redMessageSharedFileContainerColor
                              : Colors.white));
            }
            return const SizedBox();
          },
        ),
      ),
      GestureDetector(
        onTap: _showAlertDialog,
        child: Container(
          height: DeviceType().isMobile ? 8.wp : 6.5.wp,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 50.h),
            child: Image.asset('assets/images/PNG Icons/info.png'),
          ),
        ),
      ),
    ],
    title: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
      builder: (context, state) {
        if (state.status == WorkSheetSolverStatus.loaded) {
          if (state.questions.isEmpty) {
            return const SizedBox();
          }
          return Text(
              'Q.${state.currentQuestion + 1} ${state.questions[state.currentQuestion].getQuestionTypeString()}',
              textAlign: TextAlign.center,
              style: DeviceType().isMobile
                  ? AppTextStyles.uniformRounded136BoldAppBarStyle
                      .copyWith(color: Colors.white)
                  : AppTextStyles.uniformRounded136BoldAppBarStyle
                      .copyWith(fontSize: 136.sp * 0.7, color: Colors.white));
        } else {
          return const SizedBox();
        }
      },
    ),
  );
}
