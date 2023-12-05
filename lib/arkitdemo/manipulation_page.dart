import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class ManipulationPage extends StatefulWidget {
  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}

class _ManipulationPageState extends State<ManipulationPage> {
  late ARKitController arkitController;
  ARKitNode? boxNode;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Manipulation Sample')),
        body: Container(
          child: ARKitSceneView(
            enablePinchRecognizer: true,
            enablePanRecognizer: true,
            enableRotationRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);
    addNode();
  }
// void _onARTapHandler(ARKitTestResult point) {
//     final position = vector.Vector3(
//       point.worldTransform.getColumn(3).x,
//       point.worldTransform.getColumn(3).y,
//       point.worldTransform.getColumn(3).z,
//     );

//     final node = _getNodeFromFlutterAsset(position);
//     // final node = _getNodeFromNetwork(position);
//     arkitController.add(node);
//     arNode = node;
//     print('arnodename' + arNode!.name.toString());
//   }

// }
  void addNode() {
    // final material = ARKitMaterial(
    //   lightingModelName: ARKitLightingModel.physicallyBased,
    //   diffuse: ARKitMaterialProperty.color(
    //     Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
    //         .withOpacity(1.0),
    //   ),
    // );
    // final box =
    //     ARKitBox(materials: [material], width: 0.1, height: 0.1, length: 0.1);

    // final node = ARKitNode(
    //   geometry: box,
    //   position: vector.Vector3(0, 0, -0.5),
    // );
    final position = vector.Vector3(0, 0, -0.5);

    final node = _getNodeFromFlutterAsset(position);
    arkitController.add(node);
    boxNode = node;
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        // Box model from
        // https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb
        url: 'assets/temp/snail.glb',
        scale: vector.Vector3(1, 1, 1),
        position: position,
      );
  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    debugPrint('pinch node 1');
    final pinchNode = pinch.firstWhereOrNull(
      (e) => e.nodeName == boxNode?.name,
    );
    if (pinchNode != null) {
      final scale = vector.Vector3.all(pinchNode.scale);
      boxNode?.scale = scale;
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    debugPrint('pan node 1');
    final panNode = pan.firstWhereOrNull((e) => e.nodeName == boxNode?.name);
    if (panNode != null) {
      final old = boxNode?.eulerAngles;
      final newAngleY = panNode.translation.x * math.pi / 180;
      boxNode?.eulerAngles =
          vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
    }
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    debugPrint('rotation node 1');
    final rotationNode = rotation.firstWhereOrNull(
      (e) => e.nodeName == boxNode?.name,
    );
    if (rotationNode != null) {
      final rotation = boxNode?.eulerAngles ??
          vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
      boxNode?.eulerAngles = rotation;
    }
  }
}
