import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:size_config/size_config.dart';

import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../../data/models/ar_model.dart';
import '../bloc/model_page_controler_cubit/models_page_controller_cubit.dart';
import '../bloc/models_new_cubit/models_new_cubit.dart';
import 'model_3d_view.dart';

class CategoryModelsPageView extends StatefulWidget {
  // final String category;
  const CategoryModelsPageView({super.key});

  @override
  State<CategoryModelsPageView> createState() => _CategoryModelsPageViewState();
}

class _CategoryModelsPageViewState extends State<CategoryModelsPageView> {
  var isClicked = false;
  late Timer _timer;
  _startTimer() {
    _timer = Timer(const Duration(milliseconds: 400), () => isClicked = false);
  }

  @override
  void initState() {
    context.read<ModelsPageControllerCubit>().setmaxLength(
        (context.read<ModelsNewCubit>().state.arModels.length / 6).ceil());
    context.read<ModelsPageControllerCubit>().setPage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        body: ConnectionNotifierToggler(
            disconnected: const NetworkDisconnected(),
            connected: Stack(
              children: [
                BlocBuilder<ModelsNewCubit, ModelsNewState>(
                  builder: (context, state) {
                    if (state.status == ModelsStatus.loaded) {
                      //?Set Maxlen of pages (don't remove)
                      context
                          .read<ModelsPageControllerCubit>()
                          .setmaxLength((state.arModels.length / 6).ceil());
                      //?
                      return BlocBuilder<ModelsPageControllerCubit, int>(
                        builder: (context, index) {
                          debugPrint(
                              'active page idx: ${context.read<ModelsPageControllerCubit>().activePageIdx}');

                          return Padding(
                            padding: Platform.isIOS && shortestSide < 600
                                ? EdgeInsets.only(left: 6.wp)
                                : const EdgeInsets.all(0),
                            child: PageView.builder(
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
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator.adaptive(
                      strokeCap: StrokeCap.round,
                    ));
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.wp, 4.wp, 4.wp, 4.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Left Side back and User icon
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 75.h,
                            height: 75.h,
                            child: Image.asset(
                              'assets/ui/image 40.png', // User Icon
                              fit: BoxFit.contain,
                            ),
                          ),
                          //First page does'nt has back page btn
                          if (context
                                  .watch<ModelsPageControllerCubit>()
                                  .activePageIdx !=
                              0)
                            Padding(
                              padding: Platform.isIOS && shortestSide < 600
                                  ? EdgeInsets.only(left: 12.wp)
                                  : const EdgeInsets.all(0),
                              child: GestureDetector(
                                onTap: () {
                                  if (isClicked == false) {
                                    _startTimer();
                                    isClicked = true;
                                    // Your other code which you want to execute on click.
                                    context
                                        .read<ModelsPageControllerCubit>()
                                        .setPreviousPage();
                                  }
                                },
                                child: SizedBox(
                                  height: 75.h,
                                  width: 75.h,
                                  child: UnconstrainedBox(
                                    alignment: Alignment.centerLeft,
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
                          SizedBox(
                            width: 75.h,
                            height: 75.h,
                          ),
                        ],
                      ),
                      //! Right Side next and Home icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 75.h,
                            height: 75.h,
                          ),
                          //last page does'nt has next page btn
                          if (context
                                  .watch<ModelsPageControllerCubit>()
                                  .activePageIdx !=
                              context.read<ModelsPageControllerCubit>().maxLen)
                            GestureDetector(
                              onTap: () {
                                if (isClicked == false) {
                                  _startTimer();
                                  isClicked = true;
                                  // Your other code which you want to execute on click.
                                  context
                                      .read<ModelsPageControllerCubit>()
                                      .setNextPage();
                                }
                              },
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: SizedBox(
                                  height: 75.h,
                                  width: 75.h,
                                  child: UnconstrainedBox(
                                    alignment: Alignment.centerLeft,
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                              width: 75.h,
                              height: 75.h,
                              child: Image.asset(
                                'assets/ui/Custom Buttons.002 1.png', // Home Icon
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildPage(int pageIndex, List<ArModel> arModels) {
    final startIndex = pageIndex * 6;
    final endIndex = (pageIndex + 1) * 6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DeviceType().isMobile ? 20.wp : 10.wp),
          child: buildRow(startIndex, endIndex, arModels),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DeviceType().isMobile ? 20.wp : 10.wp),
          child: buildRow(startIndex + 3, endIndex, arModels),
        ),
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
                      'https://d3ag5oij4wsyi3.cloudfront.net/classroom_app/images/${arModels[colorIndex].modelId}.png',
                  imageFileName: '${arModels[colorIndex].modelId}',
                  name: arModels[colorIndex].modelName,
                  model:
                      'https://d3ag5oij4wsyi3.cloudfront.net/classroom_app/models/${arModels[colorIndex].modelId}.glb',
                )
              : const Expanded(
                  child: EmptyBox(),
                );
        },
      ),
    );
  }
}

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height - 80.h) *
            (DeviceType().isMobile ? 0.5 : 0.35),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: constraints.maxHeight * 0.75,
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: constraints.maxHeight * 0.25,
                ),
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
  final String imageFileName;
  const BuildModelContainer({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.imageFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ModelView(
            modelUrl: model,
            modelName: name,
            imageFileName: imageFileName,
          ),
        )),
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
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, _, progress) {
                        return Shimmer.fromColors(
                          baseColor: AppColors.accentColor.withOpacity(0.3),
                          highlightColor: AppColors.parentZoneScaffoldColor,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error,
                          color: AppColors
                              .redMessageSharedFileContainerColor, // Color of the error icon
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight *
                        (DeviceType().isMobile ? 0.25 : 0.2),
                    child: Center(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.wp),
                          child: Text(
                            name,
                            // overflow: TextOverflow.ellipsis,
                            style: DeviceType().isMobile
                                ? AppTextStyles.nunito100w700white
                                : AppTextStyles.nunito100w700white.copyWith(
                                    fontSize: DeviceType().isMobile
                                        ? 110.sp
                                        : 16 *
                                            MediaQuery.of(context)
                                                .size
                                                .aspectRatio,
                                  ),
                          ),
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
