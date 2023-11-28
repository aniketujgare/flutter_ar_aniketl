import 'package:flutter/material.dart';
import 'package:flutter_ar/homeview.dart';
import 'package:flutter_ar/model_3d_view.dart';

class ContainerPageView extends StatelessWidget {
  final bool isMobile;
  final List<Color> containerColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.yellow,
    Colors.grey,
    // Colors.pink,
    // Colors.brown // Add more colors as needed
  ];

  ContainerPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: (models.length / 6)
          .ceil(), // 6 containers per page (2 rows with 3 containers each)
      itemBuilder: (context, pageIndex) {
        return buildPage(pageIndex);
      },
    );
  }

  Widget buildPage(int pageIndex) {
    final startIndex = pageIndex * 6;
    final endIndex = (pageIndex + 1) * 6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: buildRow(startIndex, endIndex)),
        Expanded(child: buildRow(startIndex + 3, endIndex)),
      ],
    );
  }

  List<Map<String, String>> models = [
    {
      'name': 'Rig Man',
      'image': 'assets/model_img/rig_man.png',
      'model': 'assets/g-man_rigged__animated.glb'
    },
    {
      'name': 'Cylinder Engine',
      'image': 'assets/model_img/cylinder_engine.png',
      'model': 'assets/2CylinderEngine.glb'
    },
    {
      'name': 'Astronaut',
      'image': 'assets/model_img/astronaut.png',
      'model': 'assets/Astronaut.glb'
    },
    {
      'name': 'Dodo',
      'image': 'assets/model_img/rig_man.png',
      'model': 'assets/dodo/model/dodo.glb'
    },
    {
      'name': 'Turtle',
      'image': 'assets/model_img/cylinder_engine.png',
      'model': 'assets/turtle/model/turtle.glb'
    },
    {
      'name': 'Shark',
      'image': 'assets/model_img/astronaut.png',
      'model': 'assets/shark/model/shark.glb'
    },
    {
      'name': 'Shark',
      'image': 'assets/model_img/astronaut.png',
      'model': 'assets/shark/model/shark.glb'
    },
  ];
  Widget buildRow(int startIndex, int endIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) {
          final colorIndex = startIndex + index;
          return colorIndex < models.length
              ? buikdModelContainer(
                  image: models.elementAt(colorIndex)['image']!,
                  name: models[colorIndex]['name']!,
                  model: models[colorIndex]['model']!,
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
        margin: EdgeInsets.all(4),
        // width: double.maxFinite,
        // height: double.maxFinite,
        color: color,
        child: Center(
          child: Text(
            color.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class buikdModelContainer extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final bool isMobile;
  const buikdModelContainer({
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
        child: Container(
          margin: EdgeInsets.all(isMobile ? 4 : 14),
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
              stops: [0.75, 0.25],
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
                  height: constraints.maxHeight * 0.75,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.25,
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
