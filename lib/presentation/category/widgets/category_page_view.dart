import 'package:flutter/material.dart';
import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../data/models/ar_category.dart';
import '../bloc/category_new_cubit/category_new_cubit.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../bloc/models_new_cubit/models_new_cubit.dart';
import 'category_models_page_view.dart';

class CategoryPageView extends StatefulWidget {
  late final List<ArCategory> arCategoryies;
  late List<String> categoryImgList;

  CategoryPageView({super.key});

  @override
  State<CategoryPageView> createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  @override
  void initState() {
    widget.arCategoryies = context.read<CategoryNewCubit>().state.arCategory;
    widget.categoryImgList =
        context.read<CategoryNewCubit>().state.categoryImgList;
    context
        .read<CategoryPageCubit>()
        .setmaxLength((widget.arCategoryies.length / 6).ceil());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var arCategoryies = context.read<CategoryNewCubit>().state.arCategory;

    return BlocBuilder<CategoryPageCubit, int>(
      builder: (context, index) {
        return PageView.builder(
          controller: context.read<CategoryPageCubit>().pageCont,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            context.read<CategoryPageCubit>().setPage(value);
            debugPrint('page changed $value');
          },
          itemCount: (widget.arCategoryies.length / 6)
              .ceil(), // 6 containers per page (2 rows with 3 containers each)
          itemBuilder: (context, a) {
            return DeviceType().isMobile
                ? buildPage(a, context)
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPage(a, context),
                    ],
                  ));
          },
        );
      },
    );
  }

  Widget buildPage(int pageIndex, BuildContext context) {
    final startIndex = pageIndex * 6;
    final endIndex = (pageIndex + 1) * 6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DeviceType().isMobile ? 20.wp : 10.wp),
          child: buildRow(startIndex, endIndex, context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DeviceType().isMobile ? 20.wp : 10.wp),
          child: buildRow(startIndex + 3, endIndex, context),
        ),
      ],
    );
  }

  Widget buildRow(int startIndex, int endIndex, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) {
          final colorIndex = startIndex + index;
          return colorIndex < widget.arCategoryies.length
              ? BuildCategoryContainer(
                  image: widget.categoryImgList[colorIndex],
                  name: widget.arCategoryies[colorIndex].categoryName,
                  model:
                      'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models/{arModels[colorIndex].modelId}.glb',
                  category: '${widget.arCategoryies[colorIndex].categoryId}',
                )
              : const Expanded(child: EmptyBox());
        },
      ),
    );
  }
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const CategoryModelsPageView();
                },
              ),
            );
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
