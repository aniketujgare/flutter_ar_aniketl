//shared widget test
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class ModelCard extends StatefulWidget {
  const ModelCard({super.key});

  @override
  State<ModelCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<ModelCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
            ),
            //color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(
              'assets/images/PNG Icons/birds.png',
              height: MediaQuery.of(context).size.height * 0.245,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.1),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: const Color.fromRGBO(79, 58, 156, 1),
            ),
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              "Animals",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  //background: Paint(),
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontFamily: 'UniformRounded'),
            ),
          ),
        ],
      ),
    );
  }
}
