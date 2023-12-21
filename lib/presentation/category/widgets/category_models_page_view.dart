import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../../data/models/ar_model.dart';
import '../bloc/model_page_controler_cubit/models_page_controller_cubit.dart';
import '../bloc/models_new_cubit/models_new_cubit.dart';
import 'model_3d_view.dart';

class CategoryModelsPageView extends StatelessWidget {
  // final String category;
  CategoryModelsPageView({super.key});

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
                padding: EdgeInsets.fromLTRB(
                    (DeviceType().isMobile ? 450.w : 250.w),
                    0.h,
                    (DeviceType().isMobile ? 450.w : 250.w),
                    0.h),
                child: BlocBuilder<ModelsNewCubit, ModelsNewState>(
                  builder: (context, state) {
                    if (state.status == ModelsStatus.loaded) {
                      context
                          .read<ModelsPageControllerCubit>()
                          .setmaxLength((state.arModels.length / 6).ceil());
                      return BlocBuilder<ModelsPageControllerCubit, int>(
                        builder: (context, index) {
                          return PageView.builder(
                            itemCount: (state.arModels.length / 6)
                                .ceil(), // 6 containers per page (2 rows with 3 containers each)
                            controller: context
                                .read<ModelsPageControllerCubit>()
                                .pageCont,
                            onPageChanged: (value) {
                              context
                                  .read<ModelsPageControllerCubit>()
                                  .setPage(value);
                              debugPrint('page changed $value');
                            },
                            itemBuilder: (context, pageIndex) {
                              return DeviceType().isMobile
                                  ? buildPage(pageIndex, state.arModels)
                                  : Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildPage(pageIndex, state.arModels),
                                      ],
                                    ));
                            },
                          );
                        },
                      );
                    }
                    return Center(
                        child: Lottie.asset('assets/Loading.json',
                            height:
                                DeviceType().resposnsiveLength(400.h, 400.h)));
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
                  padding: EdgeInsets.only(
                      left: DeviceType().isMobile ? 130.w : 50.w),
                  child: SizedBox(
                    height: 45.h,
                    width: 45.h,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<ModelsPageControllerCubit>()
                            .setPreviousPage();
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                          context
                              .read<ModelsPageControllerCubit>()
                              .setNextPage();
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

  Widget buildPage(int pageIndex, List<ArModel> arModels) {
    final startIndex = pageIndex * 6;
    final endIndex = (pageIndex + 1) * 6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildRow(startIndex, endIndex, arModels),
        buildRow(startIndex + 3, endIndex, arModels),
      ],
    );
  }

  Widget buildRow(int startIndex, int endIndex, List<ArModel> arModels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) {
          final colorIndex = startIndex + index;
          return colorIndex < arModels.length
              ? BuildModelContainer(
                  image:
                      'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/images/${arModels[colorIndex].modelId}.png',
                  name: arModels[colorIndex].modelName,
                  model:
                      'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/models/${arModels[colorIndex].modelId}.glb',
                )
              : Expanded(
                  child: EmptyBox(),
                );
        },
      ),
    );
  }

  Widget buildContainer(Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        // width: double.maxFinite,
        // height: double.maxFinite,
        color: color,
        child: Center(
          child: Text(
            color.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            (DeviceType().isMobile ? 0.5.h : 0.35.h),
        // maxWidth: MediaQuery.of(context).size.height * 0.2.h,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight *
                    (DeviceType().isMobile ? 0.03 : 0.05),
              ),
              SizedBox(
                height: constraints.maxHeight *
                    (DeviceType().isMobile ? 0.63 : 0.65),
              ),
              SizedBox(
                height: constraints.maxHeight *
                    (DeviceType().isMobile ? 0.07 : 0.07),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.2,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class BuildModelContainer extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  const BuildModelContainer({
    super.key,
    required this.image,
    required this.name,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ModelView(modelUrl: model, modelName: name),
        )),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: (MediaQuery.of(context).size.height - 80.h) *
                (DeviceType().isMobile ? 0.5 : 0.5),
            //Todo: Adjust card size for tablet
          ),
          child: Container(
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
                stops: [
                  DeviceType().isMobile ? 0.75 : 0.75,
                  DeviceType().isMobile ? 0.25 : 0.25
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
              //Todo: check for tab models page
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight *
                        (DeviceType().isMobile ? 0.75 : 0.05),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight *
                        (DeviceType().isMobile ? 0.25 : 0.05),
                    child: Center(
                      //Todo: check font size for tab
                      child: Text(
                        name,
                        style: AppTextStyles.nunito100w700white,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: constraints.maxHeight *
                  //       (DeviceType().isMobile ? 0.03 : 0.05),
                  // ),
                  // SizedBox(
                  //   height: constraints.maxHeight *
                  //       (DeviceType().isMobile ? 0.63 : 0.65),
                  //   child: CachedNetworkImage(
                  //     fit: BoxFit.cover,
                  //     imageUrl: image,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: constraints.maxHeight *
                  //       (DeviceType().isMobile ? 0.07 : 0.07),
                  // ),
                  // SizedBox(
                  //   height: constraints.maxHeight * 0.2,
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       name,
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontFamily: 'Nunito',
                  //         fontWeight: FontWeight.w700,
                  //         height: 0,
                  //         fontSize: DeviceType().isMobile
                  //             ? 110.sp
                  //             : 16 * MediaQuery.of(context).size.aspectRatio,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
