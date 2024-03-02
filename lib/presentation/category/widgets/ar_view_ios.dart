import 'dart:io';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:size_config/size_config.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewIOS extends StatefulWidget {
  final String modelUrl;
  final String imageFileName;

  const ARViewIOS(
      {super.key, required this.modelUrl, required this.imageFileName});

  @override
  ARViewIOSState createState() => ARViewIOSState();
}

class ARViewIOSState extends State<ARViewIOS> {
  late ARKitController arkitController;
  ARKitNode? node;
  double _value = 0.0;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // bottomSheet: SizedBox(
        //   width: 500,
        //   height: 100,
        //   child: CupertinoSlider(
        //     min: 0.0,
        //     max: 6.28,
        //     value: _value,
        //     onChanged: (value) {
        //       _value = value;
        //       setState(() {
        //         _rotateModel();
        //       });
        //     },
        //   ),
        // ),
        body: Stack(
          children: [
            ARKitSceneView(
              showFeaturePoints: true,
              planeDetection: ARPlaneDetection.horizontal,
              enablePinchRecognizer: true,
              enableRotationRecognizer: true,
              onARKitViewCreated: onARKitViewCreated,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
                child: SizedBox(
                  height: 65.h,
                  width: 65.h,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      'assets/ui/Group.png',
                      fit: BoxFit.scaleDown,
                      // height: 45,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);

    arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    debugPrint(widget.modelUrl);
    arkitController.getCameraEulerAngles().then((rotationVector) async {
      node = ARKitGltfNode(
        assetType: AssetType.documents,
        // Box model from
        // https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb
        url:
            'file:///data/user/0/com.smartxr.kidsv2/app_flutter/assets/${widget.imageFileName}.glb',
        eulerAngles: vector.Vector3(rotationVector.y, 0,
            0), //And here is the line of code you are looking for

        scale: vector.Vector3.all(1),
      );
      //!network asset
      // node = await _getNodeFromNetwork(widget.modelUrl);
      controller.add(node!, parentNodeName: anchor.nodeName);
    });
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    final pinchNode = pinch.first;
    if (pinchNode != null) {
      debugPrint('pinch node');
      final scale = vector.Vector3.all(pinchNode.scale * 0.2);
      node?.scale = scale;
    }
  }

  _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    final rotationNode = rotation.first;
    if (rotationNode != null) {
      final rotation = vector.Vector3.zero() +
          vector.Vector3(
              (rotationNode.rotation.abs() * 50).clamp(0, 6.28), 0, 0);
      debugPrint(
          'rotation node ${(rotationNode.rotation.abs() * 50).clamp(0, 6.28)}');
      node?.eulerAngles = rotation;
    }
  }

  _rotateModel() {
    debugPrint(node?.name);
    final rotation = vector.Vector3.zero() + vector.Vector3(_value, 0, 0);
    node?.eulerAngles = rotation;
    debugPrint('rotation ${rotation}');
  }
}

Future<ARKitGltfNode> _getNodeFromNetwork(String modelUrl) async {
// And add dependencies to pubspec.yaml file
// path_provider: ^2.0.3
// dio: ^5.3.3

// Import to test file download

  final file = await _downloadFile(modelUrl);
  if (file.existsSync()) {
    //Load from app document folder
    return ARKitGltfNode(
      assetType: AssetType.documents,
      url: file.path.split('/').last, //  filename.extension only!
      scale: vector.Vector3.all(1.0),
    );
  }
  throw Exception('Failed to load $file');
}

Future<File> _downloadFile(String url) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${url.split("/").last}';
    await Dio().download(url, filePath);
    final file = File(filePath);
    debugPrint('Download completed!! path = $filePath');
    return file;
  } catch (e) {
    debugPrint('Caught an exception: $e');
    rethrow;
  }
}
