import 'package:flutter/material.dart';
import 'package:flutter_ar/container_page_view.dart';
import 'package:flutter_ar/model/ar_category.dart';

class CategoryPageView extends StatelessWidget {
  final bool isMobile;
  final List<ArCategory> arCategoryies;
  var categoryImgList = [
    'assets/images/PNG Icons/Animals.png',
    'assets/images/PNG Icons/birds.png',
    'assets/images/PNG Icons/sea life.png',
    'assets/images/PNG Icons/dinosaurs.png',
    'assets/images/PNG Icons/plants.png',
    'assets/images/PNG Icons/trees.png'
  ];

  CategoryPageView(
      {super.key, required this.isMobile, required this.arCategoryies});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: (arCategoryies.length / 6)
          .ceil(), // 6 containers per page (2 rows with 3 containers each)
      itemBuilder: (context, pageIndex) {
        return buildPage(pageIndex, context);
      },
    );
  }

  Widget buildPage(int pageIndex, BuildContext context) {
    final startIndex = pageIndex * 6;
    final endIndex = (pageIndex + 1) * 6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: buildRow(startIndex, endIndex, context)),
        Expanded(child: buildRow(startIndex + 3, endIndex, context)),
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

  Widget buildContainer(Color color) {
    return Expanded(
      child: Container(
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ContainerPageView(
                    isMobile: isMobile, category: category);
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 6 : 14, vertical: isMobile ? 8 : 14),
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
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0XFF4F3A9C)],
              tileMode: TileMode.decal,
              stops: [0.7, 0.3],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(isMobile ? 20 : 40.0),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 0.5,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.65,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile
                            ? 7.5 * MediaQuery.of(context).size.aspectRatio
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
    );
  }
}
