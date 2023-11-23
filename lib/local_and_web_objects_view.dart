import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LocalAndWebObjectsView extends StatefulWidget {
  const LocalAndWebObjectsView({super.key});

  @override
  State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
}

class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late ARAnchorManager arAnchorManager;

  ARNode? localObject;
  ARNode? webObject;
  @override
  void dispose() {
    arSessionManager.dispose();

    super.dispose();
  }

  bool localViewType = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local / Web Objects"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: localViewType
                    ? ARView(
                        onARViewCreated: _onARViewCreated,
                        planeDetectionConfig: PlaneDetectionConfig.horizontal)
                    : ARView(onARViewCreated: onWhiteARViewCreated),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onLocalObjectButtonPressed,
                    child: const Text("Add / Remove Local Object"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onWebObjectButtonPressed,
                    child: const Text("Add / Remove Web Object"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) async {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    arAnchorManager = arAnchorManager;

    arSessionManager.onInitialize(
      handlePans: true,
      handleRotation: true,
      showWorldOrigin: true,
    );

    arObjectManager.onInitialize();
  }

  Future<void> onWhiteARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) async {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    arAnchorManager = arAnchorManager;

    arSessionManager.onInitialize(
      handlePans: true,
      handleRotation: true,
      // showWorldOrigin: true,
    );

    arObjectManager.onInitialize();
  }

  void onLocalObjectButtonPressed() async {
    if (localObject != null) {
      arObjectManager.removeNode(localObject!);
      localObject = null;
    } else {
      var newNode = ARNode(
          uri: "assets/Chicken_01/Chicken_01.gltf",
          type: NodeType.localGLTF2,
          scale: vector.Vector3(0.2, 0.2, 0.2),
          // position: Vector3(0.0, 0.0, 0.0),
          rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      if (didAddLocalNode!) {
        localObject = newNode;
      } else {
        localObject = null;
      }
    }
  }

  void onWebObjectButtonPressed() async {
    if (webObject != null) {
      arObjectManager.removeNode(webObject!);
      webObject = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          scale: vector.Vector3(0.2, 0.2, 0.2),
          uri:
              "https://github.com/khronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb");
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      if (didAddLocalNode!) {
        webObject = newNode;
      } else {
        webObject = null;
      }
    }
  }

  Future<void> _onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    arSessionManager.onInitialize(
      handlePans: true,
      handleRotation: true,
      showWorldOrigin: true,
      // customPlaneTexturePath: 'assets/images/triangle.png',
    );
    arObjectManager.onInitialize();
    arAnchorManager.initGoogleCloudAnchorMode();
    arSessionManager.onPlaneOrPointTap = _onPlaneOrPointTapped;
  }

  Future<void> _onPlaneOrPointTapped(
    List<ARHitTestResult> hitTestResults,
  ) async {
    final singleHitTestResult = hitTestResults
        .firstWhere((result) => result.type == ARHitTestResultType.plane);
    final newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);

    final didAddAnchor = await arAnchorManager.addAnchor(newAnchor);
    if (didAddAnchor == true) {
      // await _copyAssetModelsToDocumentDirectory();
      final newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: 'assets/Chicken_01/Chicken_01.gltf',
        scale: vector.Vector3(0.2, 0.2, 0.2),
        position: vector.Vector3(0.0, 0.0, 0.0),
        rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
      );
      final didAddNodeToAnchor =
          await arObjectManager.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor == false) {
        arSessionManager.onError('Adding Node to Anchor failed');
      }
    } else {
      arSessionManager.onError('Adding Anchor failed');
    }
  }
}
