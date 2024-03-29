import 'package:flutter/material.dart';

class AnimationPLayGround extends StatefulWidget {
  const AnimationPLayGround({super.key});

  @override
  AnimationPLayGroundState createState() => AnimationPLayGroundState();
}

class AnimationPLayGroundState extends State<AnimationPLayGround> {
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z)
            ..setEntry(3, 2, 0.001),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dx / 100;
                x = x + details.delta.dy / 100;
                debugPrint('$x,$y');
              });
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
