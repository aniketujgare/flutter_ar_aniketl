import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/category/pages/category_screen.dart';
import 'package:flutter_ar/presentation/parent_zone/bloc/navbar_cubit/app_navigator_cubit.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/app_bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../widgets/home_view.dart';
import '../widgets/group_view.dart';
import '../widgets/reports_view.dart';
import '../widgets/settings_view.dart';

class ParentZoneScreen extends StatelessWidget {
  const ParentZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.accentColor),
      child: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.parentZoneScaffoldColor,
            appBar: AppBar(
              backgroundColor: AppColors.accentColor,
              leading: context.watch<AppNavigatorCubit>().state.index == 0
                  ? GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 200.w),
                        child: Image.asset(
                          'assets/images/reusable_icons/back_button_primary.png',
                        ),
                      ),
                      onTap: () => Navigator.pop(context),
                    )
                  : null,
              title: BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
                builder: (context, state) {
                  return Text(
                    appBarTitle[state.index],
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 160.sp,
                      fontFamily: 'Uniform Rounded',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  );
                },
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
                    builder: (context, state) {
                      return IndexedStack(
                        index: state.index,
                        children: screenList,
                      );
                    },
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: AppBottomNavBar()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var screenList = [
  const HomeView(),
  const GroupsView(),
  const ReportsView(),
  const SettingsView(),
];
var appBarTitle = [
  'Parent Zone',
  'Groups',
  'Reports',
  'Settings',
];
