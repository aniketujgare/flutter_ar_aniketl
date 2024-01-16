// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
// import 'package:flutter/services.dart';
// import 'package:size_config/size_config.dart';
// import 'package:vector_math/vector_math_64.dart';
// import 'dart:math';

// class FlutterAR extends StatefulWidget {
//   final String modelUrl;
//   const FlutterAR({Key? key, required this.modelUrl}) : super(key: key);
//   @override
//   FlutterARState createState() => FlutterARState();
// }

// class FlutterARState extends State<FlutterAR> {
//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;

//   List<ARNode> nodes = [];
//   List<ARAnchor> anchors = [];
//   ARNode? arnide;
//   @override
//   void dispose() {
//     super.dispose();
//     arSessionManager!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0Xffffffff).withOpacity(0),
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   backgroundColor: const Color(0XFFF4F2FE),
//       //   centerTitle: true,
//       //   leading: Padding(
//       //     padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
//       //     child: GestureDetector(
//       //       onTap: () => context.pop(),
//       //       child: Image.asset(
//       //         'assets/ui/Group.png',
//       //         // height: 45,
//       //       ),
//       //     ),
//       //   ),
//       //   title: FittedBox(
//       //     fit: BoxFit.contain,
//       //     child: Container(
//       //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       //       decoration: BoxDecoration(
//       //         borderRadius: BorderRadius.circular(15.0),
//       //         border: Border.all(color: Colors.black, width: 2.0),
//       //       ),
//       //       child: Text(
//       //         widget.modelName,
//       //         style: const TextStyle(fontSize: 18, color: Color(0XFF4F3A9C)),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: SizedBox.expand(
//               child: ARView(
//                 onARViewCreated: onARViewCreated,
//                 planeDetectionConfig: PlaneDetectionConfig.horizontal,
//               ),
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 10,
//             child: SizedBox(
//               height: 65.h,
//               width: 65.h,
//               child: GestureDetector(
//                 onTap: () => context.pop(),
//                 child: Image.asset(
//                   'assets/ui/Group.png',
//                   fit: BoxFit.scaleDown,
//                   // height: 45,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

//     Scaffold(
//         appBar: AppBar(
//           title: const Text('Object Transformation Gestures'),
//         ),
//         body: Stack(children: [
//           SizedBox.expand(
//             child: ARView(
//               onARViewCreated: onARViewCreated,
//               planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
//             ),
//           ),
//           // Align(
//           //   alignment: FractionalOffset.bottomCenter,
//           //   child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //       children: [
//           //         ElevatedButton(
//           //             onPressed: onRemoveEverything,
//           //             child: const Text("Remove Everything")),
//           //       ]),
//           // )
//         ]));
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;

//     this.arSessionManager!.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: "assets/images/PNG Icons/triangle.png",
//           // showWorldOrigin: true,
//           handlePans: true,
//           handleRotation: true,
//         );
//     this.arObjectManager!.onInitialize();

//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager!.onPanStart = onPanStarted;
//     this.arObjectManager!.onPanChange = onPanChanged;
//     this.arObjectManager!.onPanEnd = onPanEnded;
//     this.arObjectManager!.onRotationStart = onRotationStarted;
//     this.arObjectManager!.onRotationChange = onRotationChanged;
//     this.arObjectManager!.onRotationEnd = onRotationEnded;
//   }

//   Future<void> onRemoveEverything() async {
//     /*nodes.forEach((node) {
//       this.arObjectManager.removeNode(node);
//     });*/
//     anchors.forEach((anchor) {
//       this.arAnchorManager!.removeAnchor(anchor);
//     });
//     anchors = [];
//   }

//   Future<void> onPlaneOrPointTapped(
//       List<ARHitTestResult> hitTestResults) async {
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
//     if (singleHitTestResult != null) {
//       if (arnide == null) {
//         var newAnchor =
//             ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
//         bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
//         if (didAddAnchor!) {
//           this.anchors.add(newAnchor);
//           // Add note to anchor
//           var newNode = ARNode(
//               type: NodeType.webGLB,
//               uri: widget.modelUrl,
//               // "https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/models/1.glb",
//               scale: Vector3(0.5, 0.5, 0.5),
//               position: Vector3(0.0, 0.0, 0.0),
//               rotation: Vector4(1.0, 0.0, 0.0, 0.0));
//           arnide = newNode;
//           bool? didAddNodeToAnchor = await this
//               .arObjectManager!
//               .addNode(newNode, planeAnchor: newAnchor);
//           if (didAddNodeToAnchor!) {
//             this.nodes.add(newNode);
//           } else {
//             this.arSessionManager!.onError("Adding Node to Anchor failed");
//           }
//         } else {
//           this.arSessionManager!.onError("Adding Anchor failed");
//         }
//       }
//     }
//   }

//   onPanStarted(String nodeName) {
//     print("Started panning node " + nodeName);
//   }

//   onPanChanged(String nodeName) {
//     print("Continued panning node " + nodeName);
//   }

//   onPanEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended panning node " + nodeName);
//     final pannedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     //pannedNode.transform = newTransform;
//   }

//   onRotationStarted(String nodeName) {
//     print("Started rotating node " + nodeName);
//   }

//   onRotationChanged(String nodeName) {
//     print("Continued rotating node " + nodeName);
//   }

//   onRotationEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended rotating node " + nodeName);
//     final rotatedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     rotatedNode.transform = newTransform;
//   }
// }
