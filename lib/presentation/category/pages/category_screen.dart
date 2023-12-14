import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../widgets/category_list.dart';

class CategoryScreen extends StatelessWidget {
  final bool isMobile;

  const CategoryScreen({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFF4F2FE),
        body: Padding(
          padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB((isMobile ? 450.w : 250.w), 0.h,
                    (isMobile ? 450.w : 250.w), 0.h),
                child: CategoryList(isMobile: isMobile),
              ),
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
                  padding: EdgeInsets.only(left: isMobile ? 130.w : 50.w),
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
                child: SizedBox(
                  height: 85.h,
                  width: 85.h,
                  child: Image.asset(
                    'assets/ui/Custom Buttons.002 1.png', // Home Icon
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: isMobile ? 130.w : 50.w),
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
    );
  }
}
