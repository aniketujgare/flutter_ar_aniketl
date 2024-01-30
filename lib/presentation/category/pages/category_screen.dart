import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../main_menu/main_menu_screen.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../widgets/category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.parentZoneScaffoldColor,
          body: Padding(
              padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
              child: Row(
                children: [
                  //! left part
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 75.h,
                        child: Image.asset(
                          'assets/ui/image 40.png', // User Icon
                          fit: BoxFit.contain,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<CategoryPageCubit>().setPreviousPage(),
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
                      SizedBox(
                        width: 75.h,
                        height: 75.h,
                      ),
                    ],
                  ),
                  //! center part
                  Expanded(child: CategoryList()),
                  //! right part
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 75.h,
                        height: 75.h,
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<CategoryPageCubit>().setNextPage(),
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
                      SizedBox(
                        width: 75.h,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const MainMenuScreen()));
                          },
                          child: SizedBox(
                            height: 75.h,
                            width: 75.h,
                            child: Image.asset(
                              'assets/ui/Custom Buttons.002 1.png', // Home Icon
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )

              /*
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.wp, 4.wp, 8.wp, 4.wp),
                  child: const CategoryList(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 75.h,
                    width: 75.h,
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
                        // splashColor: AppColors.secondaryColor,
                        // borderRadius: BorderRadius.circular(50),
                        onTap: () =>
                            context.read<CategoryPageCubit>().setPreviousPage(),
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
                      height: 75.h,
                      width: 75.h,
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
                    child: GestureDetector(
                      // splashColor:  AppColors.secondaryColor,
                      // borderRadius: BorderRadius.circular(50),
                      onTap: () =>
                          context.read<CategoryPageCubit>().setNextPage(),
                      child: SizedBox(
                        height: 45.h,
                        width: 45.h,
                        child: RotatedBox(
                          quarterTurns: 2,
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
            */
              ),
        ),
      ),
    );
  }
}
