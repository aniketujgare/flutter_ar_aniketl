import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/main_menu/main_menu_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../core/util/device_type.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../widgets/category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

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
                ? EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h)
                : EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      (DeviceType().isMobile ? 450.w : 250.w),
                      0.h,
                      (DeviceType().isMobile ? 450.w : 250.w),
                      0.h),
                  child: const CategoryList(),
                ),
                // Positioned(
                //   top: 55.h,
                //   left: 275.w,
                //   child: SizedBox(
                //     height: 85.h,
                //     // width: 85.h,
                //     child: Text(
                //       'Shardul',
                //       style: AppTextStyles.uniformRounded100Bold
                //           .copyWith(fontSize: 70.sp),
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 85.h,
                    width: 85.h,
                    child: Image.asset(
                      'assets/ui/image 40.png', // User Icon
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: DeviceType().isMobile ? 130.w : 50.w),
                    child: SizedBox(
                      height: 45.h,
                      width: 45.h,
                      child: GestureDetector(
                        onTap: () {
                          context.read<CategoryPageCubit>().setPreviousPage();

                          print(
                              'tapped${context.read<CategoryPageCubit>().curridx}');
                        },
                        child: Image.asset(
                          'assets/ui/Group.png', // left arrow
                          fit: BoxFit.scaleDown,
                          height: 45.h,
                          width: 45.h,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainMenuScreen()));
                    },
                    child: SizedBox(
                      height: 85.h,
                      width: 85.h,
                      child: Image.asset(
                        'assets/ui/Custom Buttons.002 1.png', // Home Icon
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: DeviceType().isMobile ? 130.w : 50.w),
                    child: SizedBox(
                      height: 45.h,
                      width: 45.h,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: GestureDetector(
                          onTap: () {
                            context.read<CategoryPageCubit>().setNextPage();

                            print(
                                'tapped${context.read<CategoryPageCubit>().curridx}');
                          },
                          child: Image.asset(
                            'assets/ui/Group.png', // right arrow
                            fit: BoxFit.scaleDown,
                            height: 45.h,
                            width: 45.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
