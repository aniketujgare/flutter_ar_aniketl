import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/route/route_name.dart';
import 'package:flutter_ar/core/services/injection_container.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../main_menu/main_menu_screen.dart';
import '../bloc/category_new_cubit/category_new_cubit.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../bloc/model_page_controler_cubit/models_page_controller_cubit.dart';
import '../bloc/models_new_cubit/models_new_cubit.dart';
import '../widgets/category_models_page_view.dart';

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
                  Expanded(child:
                      BlocBuilder<CategoryNewCubit, CategoryNewState>(
                          builder: (context, state) {
                    if (state.status == CategoryStatus.loaded) {
                      context
                          .read<CategoryPageCubit>()
                          .setmaxLength((state.arCategory.length / 6).ceil());
                      return BlocBuilder<CategoryPageCubit, int>(
                        builder: (context, index) {
                          return PageView.builder(
                            controller:
                                context.read<CategoryPageCubit>().pageCont,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value) {
                              context.read<CategoryPageCubit>().setPage(value);
                              debugPrint('page changed $value');
                            },
                            itemCount: (state.arCategory.length / 6)
                                .ceil(), // 6 containers per page (2 rows with 3 containers each)
                            itemBuilder: (context, a) {
                              return DeviceType().isMobile
                                  ? buildPage(a, context)
                                  : Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildPage(a, context),
                                      ],
                                    ));
                            },
                          );
                        },
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator.adaptive(
                      strokeCap: StrokeCap.round,
                    ));
                  })),
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
                            context.pop();
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
              )),
        ),
      ),
    );
  }
}

Widget buildPage(int pageIndex, BuildContext context) {
  final startIndex = pageIndex * 6;
  final endIndex = (pageIndex + 1) * 6;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildRow(startIndex, endIndex, context),
      buildRow(startIndex + 3, endIndex, context),
    ],
  );
}

Widget buildRow(int startIndex, int endIndex, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(
      3,
      (index) {
        var arCategories = context.read<CategoryNewCubit>().state.arCategory;
        var categoryImgList =
            context.read<CategoryNewCubit>().state.categoryImgList;
        final colorIndex = startIndex + index;
        return colorIndex < arCategories.length
            ? BuildCategoryContainer(
                image: categoryImgList[colorIndex],
                name: arCategories[colorIndex].categoryName,
                model:
                    'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models/{arModels[colorIndex].modelId}.glb',
                category: '${arCategories[colorIndex].categoryId}',
              )
            : const Expanded(child: EmptyBox());
      },
    ),
  );
}

class BuildCategoryContainer extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final String category;
  const BuildCategoryContainer({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          var state = context.read<CategoryNewCubit>().state;
          if (state.status == CategoryStatus.loaded) {
            context.read<ModelsNewCubit>().loadModels(category);
            context.pushNamed(categoryModelsRoute);
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: (MediaQuery.of(context).size.height - 80.h) *
                (DeviceType().isMobile ? 0.5 : 0.35),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: DeviceType().isMobile ? 40.w : 20.w,
                vertical: DeviceType().isMobile ? 40.w : 20.w),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset:
                      const Offset(0, 3), // changes the position of the shadow
                ),
              ],
              gradient: LinearGradient(
                colors: const [Colors.white, Color(0XFF4F3A9C)],
                tileMode: TileMode.decal,
                stops: [
                  DeviceType().isMobile ? 0.75 : 0.8,
                  DeviceType().isMobile ? 0.25 : 0.2
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.h),
              border: Border.all(
                color: Colors.grey.shade100,
                width: 0.5,
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: constraints.maxHeight *
                        (DeviceType().isMobile ? 0.75 : 0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Image.asset(
                        // 'assets/images/PNG Icons/Dog3.png',
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight *
                        (DeviceType().isMobile ? 0.25 : 0.2),
                    child: Center(
                      child: Text(
                        name,
                        style: DeviceType().isMobile
                            ? AppTextStyles.nunito100w700white
                            : AppTextStyles.nunito100w700white.copyWith(
                                fontSize: 60.sp *
                                    MediaQuery.of(context).size.aspectRatio,
                              ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
