import 'dart:io';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../core/bloc/student_profile_cubit/student_profile_cubit.dart';
import '../../core/reusable_widgets/network_disconnected.dart';
import '../../core/util/device_type.dart';
import '../../core/util/styles.dart';
import '../category/pages/category_screen.dart';
import '../parent_zone/pages/parent_zone_screen.dart';
import '../subject/pages/subject.dart';
import '../worksheet/bloc/worksheet_cubit/worksheet_cubit.dart';
import '../worksheet/pages/worksheet.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    context.read<WorksheetCubit>().getWorksheets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: AppColors.parentZoneScaffoldColor,
          );
        } else {
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: AppColors.parentZoneScaffoldColor,
              body: ConnectionNotifierToggler(
                loading: const SizedBox.shrink(),
                disconnected: const NetworkDisconnected(),
                connected: Column(
                  children: [
                    //! Top
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                      child: buildTop(context),
                    ),
                    //! Center
                    buildCenter(context),
                    //! Bottom
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                      child: buildBottom(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  SizedBox buildTop(BuildContext context) {
    return SizedBox(
      height: DeviceType().isMobile ? 75.h : 78.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/ui/image 40.png', // User Icon
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      'assets/images/PNG Icons/esr.001.png', // User Icon
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      right: 10.h,
                      child: Text(
                        context
                                .watch<StudentProfileCubit>()
                                .state
                                .studentProfileModel
                                ?.coins
                                .toString() ??
                            '999',
                        textAlign: TextAlign.right,
                        style: DeviceType().isMobile
                            ? AppTextStyles.nunito100w700white
                            : AppTextStyles.nunito100w700white.copyWith(
                                fontSize: 60.sp *
                                    MediaQuery.of(context).size.aspectRatio),
                      ),
                    ),
                  ],
                ),
              ),
              2.horizontalSpacerPercent,
              SizedBox(
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      'assets/images/PNG Icons/esr.002.png', // User Icon
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      right: 10.h,
                      child: Text(
                        context
                                .watch<StudentProfileCubit>()
                                .state
                                .studentProfileModel
                                ?.gems
                                .toString() ??
                            '999',
                        textAlign: TextAlign.right,
                        style: DeviceType().isMobile
                            ? AppTextStyles.nunito100w700white
                            : AppTextStyles.nunito100w700white.copyWith(
                                fontSize: 60.sp *
                                    MediaQuery.of(context).size.aspectRatio),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildCenter(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    return Expanded(
        child: Padding(
      padding: Platform.isIOS && shortestSide < 600
          ? EdgeInsets.only(left: 8.wp)
          : EdgeInsets.symmetric(vertical: DeviceType().isMobile ? 5.h : 0),
      child: PageView.builder(
        itemCount: 1,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                DeviceType().isMobile ? 4.wp : 4.wp,
                DeviceType().isMobile ? 0.wp : 4.wp,
                DeviceType().isMobile ? 4.wp : 4.wp,
                DeviceType().isMobile ? 0.wp : 4.wp),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SubjectScreen()));
                    },
                    child: Image.asset(
                      'assets/images/PNG Icons/LessonsMenu.png',
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryScreen())),
                  child: Image.asset(
                    'assets/images/PNG Icons/othermenu.png',
                  ),
                )),
              ],
            ),
          );
        },
      ),
    ));
  }
}

class buildBottom extends StatelessWidget {
  final BuildContext context;
  const buildBottom(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ParentZoneScreen())),
                child: Image.asset(
                  'assets/images/PNG Icons/CustomButtonsParents.png', // User Icon
                  fit: BoxFit.contain,
                ),
              ),
              8.horizontalSpacerPercent,
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const WorksheetView();
                  }));
                },
                child: Image.asset(
                  'assets/images/PNG Icons/CustomButtonsMenu.png', // User Icon
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Image.asset(
                'assets/images/PNG Icons/CustomButtonsStore.png', // User Icon
                fit: BoxFit.contain,
              ),
              8.horizontalSpacerPercent,
              Image.asset(
                'assets/images/PNG Icons/CustomButtonsTrophy.png', // User Icon
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
