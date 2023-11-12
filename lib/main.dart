import 'package:flutter/material.dart';
import 'package:flutter_ar/model_list.dart';

import 'local_and_web_objects_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return const MaterialApp(
      home: ModelsList3D(),
    );
  }
}

void onARViewCreated() {}
