import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/category/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_ar/presentation/category/bloc/category_page_cubit/category_page_cubit.dart';
import 'package:flutter_ar/presentation/category/bloc/models_cubit/models_cubit.dart';
import 'package:flutter_ar/presentation/category/widgets/category_models_page_view.dart';
import 'package:flutter_ar/data/models/ar_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

class CategoryPageView extends StatelessWidget {
  final bool isMobile;
  final List<ArCategory> arCategoryies;
  var categoryImgList = [
    'assets/images/PNG Icons/Animals.png',
    'assets/images/PNG Icons/birds.png',
    'assets/images/PNG Icons/sea life.png',
    'assets/images/PNG Icons/dinosaurs.png',
    'assets/images/PNG Icons/plants.png',
    'assets/images/PNG Icons/trees.png',
    'assets/images/PNG Icons/Fruits & Vegetables.png',
    'assets/images/PNG Icons/my body.png',
    'assets/images/PNG Icons/monuments.png',
    'assets/images/PNG Icons/vehicles.png',
    'assets/images/PNG Icons/vehicles.png',
  ];
  CategoryPageView(
      {super.key, required this.isMobile, required this.arCategoryies});

  @override
  Widget build(BuildContext context) {
    context
        .read<CategoryPageCubit>()
        .setmaxLength((arCategoryies.length / 6).ceil());
    return BlocBuilder<CategoryPageCubit, int>(
      builder: (context, index) {
        print('page ni $index');
        return PageView.builder(
          controller: context.read<CategoryPageCubit>().pageCont,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            context.read<CategoryPageCubit>().setPage(value);
            debugPrint('page changed $value');
          },
          itemCount: (arCategoryies.length / 6)
              .ceil(), // 6 containers per page (2 rows with 3 containers each)
          itemBuilder: (context, a) {
            debugPrint('itemBuilder $a');
            return isMobile
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
          final colorIndex = startIndex + index;
          return colorIndex < arCategoryies.length
              ? BuildCategoryContainer(
                  image: categoryImgList[colorIndex],
                  name: arCategoryies[colorIndex].categoryName,
                  model:
                      'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models/{arModels[colorIndex].modelId}.glb',
                  isMobile: isMobile,
                  category: '${arCategoryies[colorIndex].categoryId}',
                )
              : Expanded(child: Container());
        },
      ),
    );
  }
}

class BuildCategoryContainer extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final bool isMobile;
  final String category;
  const BuildCategoryContainer({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.isMobile,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          var state = context.read<CategoryCubit>().state;
          if (state is CategoryLoaded) {
            context.read<ModelsCubit>().loadModels(category);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoryModelsPageView(
                      isMobile: isMobile, category: category);
                },
              ),
            );
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                (isMobile ? 0.5.h : 0.35.h),
            // maxWidth: MediaQuery.of(context).size.height * 0.2.h,
          ),
          child: Container(
            // height: 200,
            // width: 350,
            margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
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
                stops: [isMobile ? 0.7 : 0.75, isMobile ? 0.3 : 0.25],
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
                children: [
                  SizedBox(
                    height: constraints.maxHeight * (isMobile ? 0.03 : 0.05),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * (isMobile ? 0.63 : 0.65),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * (isMobile ? 0.07 : 0.07),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          fontSize: isMobile
                              ? 110.sp
                              : 16 * MediaQuery.of(context).size.aspectRatio,
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
