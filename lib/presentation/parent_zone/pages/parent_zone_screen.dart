import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/parent_zone/bloc/navbar_cubit/app_navigator_cubit.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/app_bottom_nav_bar.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/message_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'package:auto_orientation/auto_orientation.dart';
import '../../../core/rotation_mixin.dart';
import '../../../core/util/device_type.dart';
import '../widgets/home_view.dart';
import '../widgets/group_view.dart';
import '../widgets/reports_view.dart';
import '../widgets/settings_view.dart';

class ParentZoneScreen extends StatefulWidget {
  const ParentZoneScreen({super.key});

  @override
  State<ParentZoneScreen> createState() => _ParentZoneScreenState();
}

class _ParentZoneScreenState extends State<ParentZoneScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.accentColor));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.accentColor));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.accentColor,
          title: BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (context.watch<AppNavigatorCubit>().state.index == 0)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
                        height: 36.h,
                        width: 36.h,
                        child: Image.asset(
                          'assets/images/reusable_icons/back_button_primary.png',
                        ),
                      ),
                    ),
                  if (context.watch<AppNavigatorCubit>().state.index != 0)
                    SizedBox(width: 3.wp),
                  Text(
                    appBarTitle[state.index],
                    style: DeviceType().isMobile
                        ? AppTextStyles.uniformRounded136BoldAppBarStyle
                        : AppTextStyles.uniformRounded136BoldAppBarStyle
                            .copyWith(fontSize: 136.sp * 0.7),
                  ),
                ],
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
                  alignment: Alignment.bottomCenter, child: AppBottomNavBar()),
            ],
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
