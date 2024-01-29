import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';

AppBar appBarWorksheetSolver(BuildContext context) {
  return AppBar(
    toolbarHeight: DeviceType().isMobile ? 56 : 80,
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primaryColor,
    leading: null,
    title: Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(left: 0.wp, right: 6.wp),
              height: 36.h,
              width: 36.h,
              child: Image.asset(
                'assets/images/reusable_icons/back_button_primary.png',
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
            builder: (context, state) {
              if (state.status == WorkSheetSolverStatus.loaded) {
                return Text(
                    'Q.${state.currentQuestion + 1} ${state.questions[state.currentQuestion].getQuestionTypeString()}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.uniformRounded136BoldAppBarStyle
                        .copyWith(
                            fontSize:
                                DeviceType().isMobile ? 136.sp : 136.sp * 0.7,
                            color: Colors.white));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              context.read<WorksheetSolverCubit>().answerSubmit();
              Navigator.of(context).pop();
            },
            child: Container(
              height: DeviceType().isMobile ? 9.5.wp : 6.5.wp,
              margin: EdgeInsets.only(
                  right: 4.wp, left: DeviceType().isMobile ? 4.wp : 2.wp),
              decoration: ShapeDecoration(
                color: AppColors.submitGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Center(
                child: Text('Submit',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.nunito95w700white.copyWith(
                        fontSize: 95.sp * (DeviceType().isMobile ? 1.0 : 0.7))),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
