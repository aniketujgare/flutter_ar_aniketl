import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/bloc/student_profile_cubit/student_profile_cubit.dart';
import '../../../core/reusable_widgets/feature_coming_soon_alertbox.dart';
import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../parent_zone/pages/parent_zone_screen.dart';
import '../../worksheet/pages/worksheet.dart';
import '../bloc/subject_page_cubit.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    context.read<SubjectPageCubit>().setPage(0);

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
                connected: Stack(
                  alignment: Alignment.center,
                  children: [
                    //! Center Image and Subject Name
                    _buildSubjectImage(context),
                    // _buildSubjectName(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                      child: Column(
                        children: [
                          //! Top
                          buildTop(context),
                          //! Center page previous and next buttons
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              context.watch<SubjectPageCubit>().curridx == 0
                                  ? SizedBox(height: 45.h, width: 45.h)
                                  : GestureDetector(
                                      onTap: () => context
                                          .read<SubjectPageCubit>()
                                          .setPreviousPage(),
                                      child: SizedBox(
                                        height: 45.h,
                                        width: 45.h,
                                        child: Image.asset(
                                          'assets/ui/Group.png', // right arrow
                                          fit: BoxFit.scaleDown,
                                          height: 45.h,
                                          width: 45.h,
                                        ),
                                      ),
                                    ),
                              context.watch<SubjectPageCubit>().curridx ==
                                      context.watch<SubjectPageCubit>().maxLen
                                  ? SizedBox(height: 45.h, width: 45.h)
                                  : GestureDetector(
                                      onTap: () => context
                                          .read<SubjectPageCubit>()
                                          .setNextPage(),
                                      child: RotatedBox(
                                        quarterTurns: 2,
                                        child: SizedBox(
                                          height: 45.h,
                                          width: 45.h,
                                          child: Image.asset(
                                            'assets/ui/Group.png', // right arrow
                                            fit: BoxFit.scaleDown,
                                            height: 45.h,
                                            width: 45.h,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                          //! Bottom
                          buildBottom(context),
                        ],
                      ),
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

  BlocBuilder<SubjectPageCubit, int> _buildSubjectName() {
    List<String> subNames = ['E.V.S', 'English', 'Maths'];
    return BlocBuilder<SubjectPageCubit, int>(
      builder: (context, state) {
        return Positioned(
          bottom: 35.h,
          child: Text(
            subNames[state],
            textAlign: TextAlign.center,
            style: AppTextStyles.unitedRounded95w700,
          ),
        );
      },
    );
  }

  SizedBox buildTop(BuildContext context) {
    return SizedBox(
      height: DeviceType().isMobile ? 75.h : 78.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.asset(
              'assets/images/reusable_icons/back_button_primary.png',
              height: 50.h, // User Icon
              fit: BoxFit.contain,
            ),
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
                                .read<StudentProfileCubit>()
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
                                .read<StudentProfileCubit>()
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

  BlocBuilder _buildSubjectImage(BuildContext context) {
    List<String> subImages = ['evs', 'english', 'math'];
    List<String> subNames = ['E.V.S', 'English', 'Maths'];

    return BlocBuilder<SubjectPageCubit, int>(
      builder: (context, index) {
        return PageView.builder(
          controller: context.read<SubjectPageCubit>().pageCont,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            context.read<SubjectPageCubit>().setPage(value);
          },
          itemCount: context.read<SubjectPageCubit>().maxLen + 1,
          itemBuilder: (context, a) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: double.maxFinite,
                    padding: EdgeInsets.fromLTRB(0, 8.wp, 0, 12.wp),
                    child: Image.asset(
                      'assets/images/PNG Icons/${subImages[a]}.png',
                      fit: BoxFit.contain,
                    )),
                Positioned(
                  bottom: 35.h,
                  child: Text(
                    subNames[a],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.unitedRounded95w700,
                  ),
                )
              ],
            );
          },
        );
      },
    );
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
                    return WorksheetView();
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
              GestureDetector(
                onTap: () async => await showFeatureComingSoonAertBox(
                    context, 'Store feature coming soon...'),
                child: Image.asset(
                  'assets/images/PNG Icons/CustomButtonsStore.png',
                  fit: BoxFit.contain,
                ),
              ),
              8.horizontalSpacerPercent,
              GestureDetector(
                onTap: () async => await showFeatureComingSoonAertBox(
                    context, 'Trophies and Perks Feature coming soon...'),
                child: Image.asset(
                  'assets/images/PNG Icons/CustomButtonsTrophy.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
