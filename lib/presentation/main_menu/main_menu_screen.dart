import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/category/pages/category_screen.dart';
import 'package:flutter_ar/presentation/worksheet/pages/worksheet.dart';
import 'package:flutter_ar/presentation/parent_zone/pages/parent_zone_screen.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/message_view.dart';
import 'package:go_router/go_router.dart';
import 'package:size_config/size_config.dart';
import 'package:orientation_widget/orientation_widget.dart';

import '../subject/pages/subject.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait)
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: AppColors.parentZoneScaffoldColor,
          );
        else {
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: AppColors.parentZoneScaffoldColor,
              body: Padding(
                padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                child: Column(
                  children: [
                    //! Top
                    buildTop(context),
                    //! Center
                    buildCenter(context),
                    //! Bottom
                    buildBottom(context),
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
      height: 75.h,
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

  Expanded buildCenter(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: DeviceType().isMobile ? 5.h : 0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const SubjectScreen()));
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
      ),
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
