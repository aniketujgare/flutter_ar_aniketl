import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../bloc/navbar_cubit/app_navigator_cubit.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      width: double.infinity,
      height: 100.h,
      color: AppColors.accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildNavBarItems(
            index: 0,
            context: context,
            pngIcon: 'assets/images/parent_zone/home.png',
          ),
          buildNavBarItems(
            index: 1,
            context: context,
            pngIcon: 'assets/images/parent_zone/groups.png',
          ),
          buildNavBarItems(
            index: 2,
            context: context,
            pngIcon: 'assets/images/parent_zone/reports.png',
          ),
          buildNavBarItems(
            index: 3,
            context: context,
            pngIcon: 'assets/images/parent_zone/settings.png',
          ),
        ],
      ),
    );
  }

  buildNavBarItems({
    required BuildContext context,
    required String pngIcon,
    required int index,
  }) {
    return BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<AppNavigatorCubit>().gotoPageAtIndex(index);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Image.asset(
              pngIcon,
            ),
          ),
        );
      },
    );
  }
}
