// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class LoginUiWidget extends StatelessWidget {
  const LoginUiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromRGBO(140, 125, 240, 0.9),
        ),
        // ArcBackground(),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.09,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/Dog/dog01.png',
              height: MediaQuery.of(context).size.height * 0.18,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.23,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/Dog/Paws.png',
              height: MediaQuery.of(context).size.height * 0.09,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.22,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/Dog/dog03.png',
              height: MediaQuery.of(context).size.height * 0.06,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.12,
          top: MediaQuery.of(context).size.height * 0.31,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/SxrLogo/smartXr_logo.png',
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.358,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Transform(
              transform: Matrix4.identity()..rotateZ(-15 * 3.1415927 / 180),
              alignment: FractionalOffset.center,
              child: Image.asset(
                'assets/images/SxrLogo/kidsLogo.png',
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
          ),
        ),
      ],
      //ArcBackground()
    );
  }
}
