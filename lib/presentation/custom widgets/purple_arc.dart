import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ArcBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedClipper(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        color: Colors.white,
        //child: Image.asset('assets/images/dog/dog01.png'),
      ),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
