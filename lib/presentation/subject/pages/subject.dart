import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

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
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    context.read<SubjectPageCubit>().setPage(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            //! Center Image and Subject Name
            _buildSubjectImage(context),
            _buildSubjectName(),
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
                      GestureDetector(
                        onTap: () =>
                            context.read<SubjectPageCubit>().setPreviousPage(),
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
                      GestureDetector(
                        onTap: () =>
                            context.read<SubjectPageCubit>().setNextPage(),
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
      height: 75.h,
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
              Stack(
                alignment: Alignment.centerRight,
                clipBehavior: Clip.hardEdge,
                children: [
                  Image.asset(
                    'assets/images/PNG Icons/esr.001.png', // User Icon
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: DeviceType().isMobile ? 15.wp : 9.wp,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '999',
                        textAlign: TextAlign.center,
                        style: DeviceType().isMobile
                            ? AppTextStyles.nunito100w700white
                            : AppTextStyles.nunito100w700white.copyWith(
                                fontSize: 60.sp *
                                    MediaQuery.of(context).size.aspectRatio),
                      ),
                    ),
                  ),
                ],
              ),
              2.horizontalSpacerPercent,
              Stack(
                alignment: Alignment.centerRight,
                clipBehavior: Clip.hardEdge,
                children: [
                  Image.asset(
                    'assets/images/PNG Icons/esr.002.png', // User Icon
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: DeviceType().isMobile ? 15.wp : 9.wp,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '999',
                        textAlign: TextAlign.center,
                        style: DeviceType().isMobile
                            ? AppTextStyles.nunito100w700white
                            : AppTextStyles.nunito100w700white.copyWith(
                                fontSize: 60.sp *
                                    MediaQuery.of(context).size.aspectRatio),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  BlocBuilder _buildSubjectImage(BuildContext context) {
    List<String> subImages = ['evs', 'english', 'math'];

    return BlocBuilder<SubjectPageCubit, int>(
      builder: (context, index) {
        return PageView.builder(
          controller: context.read<SubjectPageCubit>().pageCont,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            context.read<SubjectPageCubit>().setPage(value);
          },
          itemCount: 3, // 6 containers per page (2 rows with 3 containers each)
          itemBuilder: (context, a) {
            return Container(
                height: double.maxFinite,
                padding: EdgeInsets.fromLTRB(0, 8.wp, 0, 12.wp),
                child: Image.asset(
                  'assets/images/PNG Icons/${subImages[a]}.png',
                  fit: BoxFit.contain,
                ));
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
