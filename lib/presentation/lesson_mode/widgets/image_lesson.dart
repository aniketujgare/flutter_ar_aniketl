import 'package:flutter/material.dart';

class ImageLesson extends StatelessWidget {
  final String imgUrl;
  const ImageLesson({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.network(imgUrl),
    );
  }
}
