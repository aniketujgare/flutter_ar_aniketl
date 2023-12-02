import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class LoadGltfOrGlbFilePage extends StatefulWidget {
  @override
  State<LoadGltfOrGlbFilePage> createState() => _LoadGltfOrGlbFilePageState();
}

class _LoadGltfOrGlbFilePageState extends State<LoadGltfOrGlbFilePage> {
  late ARKitController arkitController;
  ARKitNode? arNode;
  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Load .gltf or .glb')),
        body: ARKitSceneView(
          showFeaturePoints: true,
          enableTapRecognizer: true,
          enablePinchRecognizer: true,
          enablePanRecognizer: true,
          enableRotationRecognizer: true,
          // debug: true,
          planeDetection: ARPlaneDetection.horizontalAndVertical,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.existingPlane,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    debugPrint('pinching 1');
    // final pinchNode = pinch.firstWhereOrNull((e) => e.nodeName == arNode?.name);
    // if (pinchNode != null) {
    //   var scale = vector.Vector3.all(pinchNode.scale);
    //   pinchNode.scale;
    //   arNode?.scale = scale;
    //   debugPrint('pinching 2');
    // }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    debugPrint('pinching 1');
    // final panNode = pan.firstWhereOrNull((e) => e.nodeName == arNode?.name);
    // if (panNode != null) {
    //   final old = arNode?.eulerAngles;
    //   final newAngleY = panNode.translation.x * math.pi / 180;
    //   arNode?.eulerAngles = vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
    //   debugPrint('pinching 1');
    // }
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    debugPrint('pinching 1');
    // final rotationNode = rotation.firstWhereOrNull(
    //   (e) => e.nodeName == arNode?.name,
    // );
    // if (rotationNode != null) {
    //   final rotation = arNode?.eulerAngles ??
    //       vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
    //   arNode?.eulerAngles = rotation;
    //   debugPrint('pinching 1');
    // }
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final node = _getNodeFromFlutterAsset(position);
    // final node = _getNodeFromNetwork(position);
    arkitController.add(node);
    arNode = node;
    print('arnodename' + arNode!.name.toString());
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        // Box model from
        // https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb
        url: 'assets/Chicken_01/Chicken_01.gltf',
        scale: vector.Vector3(0.001, 0.001, 0.001),
        position: position,
      );
}

// Future<ARKitGltfNode> _getNodeFromNetwork(vector.Vector3 position) async {
// And add dependencies to pubspec.yaml file
// path_provider: ^2.0.3
// dio: ^5.3.3
//
// Import to test file download
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
//
//  final file = await _downloadFile(
//          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb");
//  if (file.existsSync()) {
//    //Load from app document folder
//    return ARKitGltfNode(
//      assetType: AssetType.documents,
//      url: file.path.split('/').last, //  filename.extension only!
//      scale: vector.Vector3(0.01, 0.01, 0.01),
//      position: position,
//    );
//  }
//  throw Exception('Failed to load $file');
// }
//
// Future<File> _downloadFile(String url) async {
//   try {
//     final dir = await getApplicationDocumentsDirectory();
//     final filePath = '${dir.path}/${url.split("/").last}';
//     await Dio().download(url, filePath);
//     final file = File(filePath);
//     print('Download completed!! path = $filePath');
//     return file;
//   } catch (e) {
//     print('Caught an exception: $e');
//     rethrow;
//   }
// }
