import 'package:flutter/material.dart';

class NetworkConnectionCheck extends StatefulWidget {
  const NetworkConnectionCheck({super.key});

  @override
  State<NetworkConnectionCheck> createState() => _NetworkConnectionCheckState();
}

class _NetworkConnectionCheckState extends State<NetworkConnectionCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 226, 232, 235),
      child: const AspectRatio(
        aspectRatio: 5 / 11,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.wifi,
            color: Colors.grey,
            size: 100,
          ),
          Text(
            "Checking connection...",
            style: TextStyle(color: Colors.purple, fontSize: 20),
          )
        ]),
      ),
    ));
  }
}
