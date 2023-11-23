import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/constants.dart';
import 'package:flutter_ar/homeview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool device = isMobile(context);
    return MaterialApp(
      home: HomeView(isMobile: device),
    );
  }
}

// void onARViewCreated() {}
