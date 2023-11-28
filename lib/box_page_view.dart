import 'package:flutter/material.dart';

class BoxPageView extends StatelessWidget {
  final List<Color> boxColors = [Colors.blue, Colors.green, Colors.orange];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: (boxColors.length / 3).ceil(),
      itemBuilder: (context, pageIndex) {
        return buildPage(pageIndex);
      },
    );
  }

  Widget buildPage(int pageIndex) {
    final startIndex = pageIndex * 3;
    final endIndex = (pageIndex + 1) * 3;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount:
          endIndex > boxColors.length ? boxColors.length - startIndex : 3,
      itemBuilder: (context, index) {
        final colorIndex = startIndex + index;
        return buildBox(boxColors[colorIndex]);
      },
    );
  }

  Widget buildBox(Color color) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 100.0,
      color: color,
      child: Center(
        child: Text(
          color.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
