import 'package:flutter/material.dart';
import 'package:flutter_ar/api/api.dart';
import 'package:flutter_ar/model/ar_model.dart';
import 'package:flutter_ar/model_3d_view.dart';
import 'package:size_config/size_config.dart';

class ContainerPageView extends StatelessWidget {
  final bool isMobile;
  final String category;
  ContainerPageView(
      {super.key, required this.isMobile, required this.category});

  @override
  Widget build(BuildContext context) {
    List<ArModel> arModels;
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
                  future: API().getModel(category),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> arModelsSnapshot) {
                    if (arModelsSnapshot.hasData) {
                      arModels = arModelsSnapshot.data;
                      return PageView.builder(
                        itemCount: (arModelsSnapshot.data.length / 6)
                            .ceil(), // 6 containers per page (2 rows with 3 containers each)
                        itemBuilder: (context, pageIndex) {
                          return isMobile
                              ? buildPage(pageIndex, arModelsSnapshot.data)
                              : Center(
                                  child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildPage(pageIndex, arModelsSnapshot.data),
                                  ],
                                ));
                        },
                      );
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

  // List<Map<String, String>> models = [
  //   {
  //     'name': 'Rig Man',
  //     'image': 'assets/model_img/rig_man.png',
  //     'model': 'assets/g-man_rigged__animated.glb'
  //   },
  //   {
  //     'name': 'Cylinder Engine',
  //     'image': 'assets/model_img/cylinder_engine.png',
  //     'model': 'assets/2CylinderEngine.glb'
  //   },
  //   {
  //     'name': 'Astronaut',
  //     'image': 'assets/model_img/astronaut.png',
  //     'model': 'assets/Astronaut.glb'
  //   },
  //   {
  //     'name': 'Dodo',
  //     'image': 'assets/model_img/rig_man.png',
  //     'model': 'assets/dodo/model/dodo.glb'
  //   },
  //   {
  //     'name': 'Turtle',
  //     'image': 'assets/model_img/cylinder_engine.png',
  //     'model': 'assets/turtle/model/turtle.glb'
  //   },
  //   {
  //     'name': 'Shark',
  //     'image': 'assets/model_img/astronaut.png',
  //     'model': 'assets/shark/model/shark.glb'
  //   },
  //   {
  //     'name': 'Shark',
  //     'image': 'assets/model_img/astronaut.png',
  //     'model': 'assets/shark/model/shark.glb'
  //   },
  // ];
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
                  isMobile: isMobile,
                )
              : Expanded(child: Container());
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

class BuildModelContainer extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final bool isMobile;
  const BuildModelContainer({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.isMobile,
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
            maxHeight: MediaQuery.of(context).size.height *
                (isMobile ? 0.5.h : 0.35.h),
            // maxWidth: MediaQuery.of(context).size.height * 0.2.h,
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
                    child: Image.network(
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
