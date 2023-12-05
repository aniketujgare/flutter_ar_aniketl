import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 226, 232, 235),
      child: const AspectRatio(
        aspectRatio: 5 / 11,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.sync,
            color: Colors.grey,
            size: 100,
          ),
          Text(
            "Loading...",
            style: TextStyle(color: Colors.purple, fontSize: 20),
          )
        ]),
      ),
    ));
  }
}
