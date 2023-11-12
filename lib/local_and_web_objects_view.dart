import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class LocalAndWebObjectsView extends StatefulWidget {
  const LocalAndWebObjectsView({super.key});

  @override
  State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
}

class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  ARNode? localObject;
  ARNode? webObject;
  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

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
                child: ARView(onARViewCreated: onARViewCreated),
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

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
      handleTaps: false,
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
          scale: Vector3(0.2, 0.2, 0.2),
          // position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      print("newNode" + newNode.toString());
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
          scale: Vector3(0.2, 0.2, 0.2),
          uri:
              "https://github.com/khronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb");
      print("newNode" + newNode.toString());
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      if (didAddLocalNode!) {
        webObject = newNode;
      } else {
        webObject = null;
      }
    }
  }
}
