import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class CustomObjectPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<CustomObjectPage> {
  late ARKitController arkitController;
  ARKitNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Custom object on plane Sample'),
          actions: [
            IconButton(
                onPressed: _rotateobj, icon: Icon(Icons.rotate_90_degrees_ccw))
          ],
        ),
        body: Column(
          children: [
            // Slider(value: 1.0, onChanged: onChanged),
            Container(
              child: ARKitSceneView(
                showFeaturePoints: true,
                planeDetection: ARPlaneDetection.horizontal,
                enablePinchRecognizer: true,
                enableRotationRecognizer: true,
                onARKitViewCreated: onARKitViewCreated,
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
    arkitController.getCameraEulerAngles().then((rotationVector) {
      node = ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        // Box model from
        // https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb
        url: 'assets/vehicles/Sportscar/Sportscar.glb',
        eulerAngles: vector.Vector3(rotationVector.y, 0,
            0), //And here is the line of code you are looking for

        scale: vector.Vector3.all(0.3),
      );
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
      debugPrint('rotation node');
      // final double rotation = node?.transform.rotateY(rotationNode.rotation);
      node?.transform.setRotationY(rotationNode.rotation);
    }
  }

  _rotateobj() {
    node?.transform.setRotationY(23);
  }
}
