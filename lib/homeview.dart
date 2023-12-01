import 'package:flutter/material.dart';
import 'package:flutter_ar/api/api.dart';
import 'package:flutter_ar/category_page_view.dart';

import 'package:flutter_ar/model_3d_view.dart';
import 'package:size_config/size_config.dart';

import 'model/ar_category.dart';

class HomeView extends StatelessWidget {
  final bool isMobile;
  const HomeView({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: FutureBuilder(
                  future: API().getCategories(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ArCategory>?> snapshot) {
                    if (snapshot.hasData) {
                      return CategoryPageView(
                          isMobile: isMobile, arCategoryies: snapshot.data!);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
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
                    child: Image.asset(
                      'assets/ui/Group.png', // left arrow
                      fit: BoxFit.scaleDown,
                      height: 45.h,
                      width: 45.h,
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
            ],
          ),
        ),
      ),
    );
  }
}
