import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/reusable_widgets/network_disconnected.dart';
import 'package:flutter_ar/presentation/parent_zone/bloc/parent_details_cubit/parent_details_cubit.dart';
import '../../../core/util/styles.dart';
import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/message_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
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
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.accentColor));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    context.read<ParentDetailsCubit>().getParentDetails();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.parentZoneScaffoldColor));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            backgroundColor: AppColors.parentZoneScaffoldColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.accentColor,
              toolbarHeight: DeviceType().isMobile ? null : 80.h,
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
            body: ConnectionNotifierToggler(
              disconnected: const NetworkDisconnected(),
              connected: PopScope(
                canPop: false,
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
          );
        } else {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: AppColors.parentZoneScaffoldColor,
          );
        }
      },
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
