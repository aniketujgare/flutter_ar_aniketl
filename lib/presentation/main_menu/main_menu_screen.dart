import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/category/pages/category_screen.dart';
import 'package:size_config/size_config.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0XFFF4F2FE),
          body: Padding(
            padding: DeviceType().isMobile
                ? EdgeInsets.fromLTRB(160.w, 40.h, 160.w, 40.h)
                : EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: (MediaQuery.of(context).size.width -
                    //             (DeviceType().isMobile ? 320.w : 232.w)) *
                    //         0.001,
                    //     vertical: MediaQuery.of(context).size.width * 0.01),

                    // padding: EdgeInsets.fromLTRB(
                    //     (DeviceType().isMobile ? 350.w : 150.w),
                    //     0.h,
                    //     (DeviceType().isMobile ? 350.w : 150.w),
                    //     0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset(
                            'assets/images/PNG Icons/LessonsMenu.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryScreen())),
                              child: Image.asset(
                                'assets/images/PNG Icons/othermenu.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 70.h,
                    width: 70.h,
                    child: Image.asset(
                      'assets/ui/image 40.png', // User Icon
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: DeviceType().resposnsiveLength(110.h, 70.h),
                        // width: DeviceType().resposnsiveLength(800.w, 110.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/PNG Icons/esr.001.png', // User Icon
                              fit: BoxFit.contain,
                            ),
                            // Positioned(
                            //   right: 13.h,
                            //   top: 15.h,
                            //   child: Text(
                            //     '999',
                            //     style:
                            //         AppTextStyles.nunito100w700white.copyWith(
                            //       fontSize: DeviceType()
                            //           .resposnsiveLength(140.sp, 160.sp),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.h),
                      SizedBox(
                        // height: DeviceType().resposnsiveLength(1250.w, 110.h),
                        width: DeviceType().resposnsiveLength(800.w, 110.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/PNG Icons/esr.002.png', // User Icon
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              right: 13.h,
                              top: 15.h,
                              child: Text(
                                '999',
                                style: AppTextStyles.nunito100w700white
                                    .copyWith(
                                        fontSize: DeviceType()
                                            .resposnsiveLength(140.sp, 160.sp)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: DeviceType().resposnsiveLength(125.h, 110.h),
                        width: DeviceType().resposnsiveLength(125.h, 110.h),
                        child: Image.asset(
                          'assets/images/PNG Icons/CustomButtonsStore.png', // User Icon
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 20.h),
                      SizedBox(
                        height: DeviceType().resposnsiveLength(125.h, 110.h),
                        width: DeviceType().resposnsiveLength(125.h, 110.h),
                        child: Image.asset(
                          'assets/images/PNG Icons/CustomButtonsTrophy.png', // User Icon
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: DeviceType().resposnsiveLength(125.h, 110.h),
                        width: DeviceType().resposnsiveLength(125.h, 110.h),
                        child: Image.asset(
                          'assets/images/PNG Icons/CustomButtonsParents.png', // User Icon
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 20.h),
                      SizedBox(
                        height: DeviceType().resposnsiveLength(125.h, 110.h),
                        width: DeviceType().resposnsiveLength(125.h, 110.h),
                        child: Image.asset(
                          'assets/images/PNG Icons/CustomButtonsMenu.png', // User Icon
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.only(left: DeviceType().isMobile ? 130.w : 50.w),
                //     child: SizedBox(
                //       height: 45.h,
                //       width: 45.h,
                //       child: GestureDetector(
                //         onTap: () {
                //           // context.read<CategoryPageCubit>().setPreviousPage();

                //           // print(
                //           //     'tapped${context.read<CategoryPageCubit>().curridx}');
                //         },
                //         child: Image.asset(
                //           'assets/ui/Group.png', // left arrow
                //           fit: BoxFit.scaleDown,
                //           height: 45.h,
                //           width: 45.h,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: SizedBox(
                //     height: 85.h,
                //     width: 85.h,
                //     child: Image.asset(
                //       'assets/ui/Custom Buttons.002 1.png', // Home Icon
                //       fit: BoxFit.contain,
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: EdgeInsets.only(right: DeviceType().isMobile ? 130.w : 50.w),
                //     child: SizedBox(
                //       height: 45.h,
                //       width: 45.h,
                //       child: RotatedBox(
                //         quarterTurns: 2,
                //         child: GestureDetector(
                //           onTap: () {
                //             // context.read<CategoryPageCubit>().setNextPage();

                //             // print(
                //             //     'tapped${context.read<CategoryPageCubit>().curridx}');
                //           },
                //           child: Image.asset(
                //             'assets/ui/Group.png', // right arrow
                //             fit: BoxFit.scaleDown,
                //             height: 45.h,
                //             width: 45.h,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
