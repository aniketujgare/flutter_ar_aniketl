// import 'dart:io';

// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
// import 'package:path_provider/path_provider.dart';

// class ARCore2 extends StatefulWidget {
//   @override
//   _ARCore2State createState() => _ARCore2State();
// }

// class _ARCore2State extends State<ARCore2> {
//   late ArCoreController arCoreController;
//   ArCoreReferenceNode? arNode;
//   HttpClient? httpClient;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Hello World'),
//         ),
//         body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//           enableTapRecognizer: true,
//           enableUpdateListener: true,
//         ),
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     arCoreController?.onNodeTap = (name) => onTapHandler(name);
//     arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
//   }

//   void _handleOnPlaneDetected(ArCorePlane plane) {
//     print('Plane Detected');
//     if (arNode == null) {
//       _addModel1(plane);
//       // arCoreController?.removeNode(nodeName: arNode!.name);
//     }
//     // _addModel1(plane);
//   }

//   Future _addModel1(ArCorePlane plane) async {
//     arNode = ArCoreReferenceNode(
//       scale: vector.Vector3.all(0.5),
//       position: plane.centerPose?.translation,
//       rotation: plane.centerPose?.rotation,
//       objectUrl:
//           'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/models/1.glb',
//     );

//     arCoreController?.addArCoreNodeWithAnchor(arNode!);
//   }

//   void onTapHandler(String name) async {
//     print("Flutter: onNodeTap");
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) =>
//           AlertDialog(content: Text('onNodeTap on $name')),
//     );
//   }
//   // Future<String> _downloadFile(String url, String filename) async {
//   //   httpClient = new HttpClient();
//   //   var request = await httpClient!.getUrl(Uri.parse(url));
//   //   var response = await request.close();
//   //   var bytes = await consolidateHttpClientResponseBytes(response);
//   //   String dir = (await getApplicationDocumentsDirectory()).path;
//   //   File file = new File('$dir/$filename');
//   //   await file.writeAsBytes(bytes);
//   //   print("Downloading finished, path: " + '$dir/$filename');
//   //   return '$dir/$filename';
//   // }

//   void _addGltf(ArCoreController controller) async {
//     // var path = await _downloadFile(
//     //     'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models/1.glb',
//     //     '1.glb');
//     final nodeAr = ArCoreReferenceNode(
//       scale: vector.Vector3.all(0.2),
//       objectUrl:
//           'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/models/1.glb',
//     );
//     controller.addArCoreNodeWithAnchor(nodeAr);
//     controller.onPlaneDetected;
//     // controller.addArCoreNode(nodeAr);
//   }

//   void _addSphere(ArCoreController controller) {
//     final material = ArCoreMaterial(color: Color.fromARGB(120, 66, 134, 244));
//     final sphere = ArCoreSphere(
//       materials: [material],
//       radius: 0.1,
//     );
//     final node = ArCoreNode(
//       shape: sphere,
//       position: vector.Vector3(0, 0, -1.5),
//     );
//     controller.addArCoreNode(node);
//   }

//   void _addCylindre(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Colors.red,
//       reflectance: 1.0,
//     );
//     final cylindre = ArCoreCylinder(
//       materials: [material],
//       radius: 0.5,
//       height: 0.3,
//     );
//     final node = ArCoreNode(
//       shape: cylindre,
//       position: vector.Vector3(0.0, -0.5, -2.0),
//     );
//     controller.addArCoreNode(node);
//   }

//   void _addCube(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Color.fromARGB(120, 66, 134, 244),
//       metallic: 1.0,
//     );
//     final cube = ArCoreCube(
//       materials: [material],
//       size: vector.Vector3(0.5, 0.5, 0.5),
//     );
//     final node = ArCoreNode(
//       shape: cube,
//       position: vector.Vector3(-0.5, 0.5, -3.5),
//     );
//     controller.addArCoreNode(node);
//   }

//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }
// }
