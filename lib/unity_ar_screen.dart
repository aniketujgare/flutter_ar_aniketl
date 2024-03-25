import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityARScreen extends StatefulWidget {
  const UnityARScreen({Key? key}) : super(key: key);

  @override
  State<UnityARScreen> createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityARScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PopScope(
        canPop: true,
        onPopInvoked: (val) async {
          await exitGame();
        },
        child: Container(
          color: AppColors.primaryColor,
          child: UnityWidget(
            onUnityCreated: onUnityCreated,
          ),
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  Future<void> exitGame() async {
    try {
      await _unityWidgetController?.unload();
      _unityWidgetController?.dispose();
      _unityWidgetController = null;
      return;
    } catch (e) {
      log("Error: $e");
    }
  }
}
