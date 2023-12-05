import 'package:flutter/material.dart';

class LessonsContainer extends StatefulWidget {
  const LessonsContainer({super.key});

  @override
  State<LessonsContainer> createState() => _LessonsContainerState();
}

class _LessonsContainerState extends State<LessonsContainer> {
  List<String> images = [
    'assets/images/PNG Icons/evs.png',
    'assets/images/PNG Icons/english.png',
    'assets/images/PNG Icons/maths.png'
  ];

  int currentImageIndex = 0;

  void updateImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % images.length;
    });
  }

  void backImage() {
    setState(() {
      currentImageIndex = (currentImageIndex - 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RotatedBox(
          quarterTurns: 2,
          child: IconButton(
            icon: Icon(Icons.play_circle_outline),
            iconSize: MediaQuery.of(context).size.height * 0.1,
            onPressed: () {
              backImage();
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.width * 0.5,
          //color: Colors.blueGrey,
          child: Image.asset(images[currentImageIndex]),
        ),
        IconButton(
          icon: Icon(Icons.play_circle_outline),
          iconSize: MediaQuery.of(context).size.height * 0.1,
          onPressed: () {
            updateImage();
          },
        ),
      ]),
    );
  }
}
