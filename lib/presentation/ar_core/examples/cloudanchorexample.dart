// import 'dart:convert';

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
// import 'package:vector_math/vector_math_64.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:geolocator/geolocator.dart';

// class CloudAnchorWidget extends StatefulWidget {
//   CloudAnchorWidget({Key? key}) : super(key: key);
//   @override
//   _CloudAnchorWidgetState createState() => _CloudAnchorWidgetState();
// }

// class _CloudAnchorWidgetState extends State<CloudAnchorWidget> {
//   // Firebase stuff
//   bool _initialized = false;
//   bool _error = false;
//   Map<String, Map> anchorsInDownloadProgress = Map<String, Map>();

//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;
//   ARLocationManager? arLocationManager;

//   List<ARNode> nodes = [];
//   List<ARAnchor> anchors = [];
//   String lastUploadedAnchor = "";

//   bool readyToUpload = false;
//   bool readyToDownload = true;

//   @override
//   void initState() {

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     arSessionManager!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Show error message if initialization failed
//     if (_error) {
//       return Scaffold(
//           appBar: AppBar(
//             title: const Text('Cloud Anchors'),
//           ),
//           body: Container(
//               child: Center(
//                   child: Column(
//             children: [
//               Text("Firebase initialization failed"),
//               ElevatedButton(
//                   child: Text("Retry"), onPressed: () => {initState()})
//             ],
//           ))));
//     }

//     // Show a loader until FlutterFire is initialized
//     if (!_initialized) {
//       return Scaffold(
//           appBar: AppBar(
//             title: const Text('Cloud Anchors'),
//           ),
//           body: Container(
//               child: Center(
//                   child: Column(children: [
//             CircularProgressIndicator(),
//             Text("Initializing Firebase")
//           ]))));
//     }

//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cloud Anchors'),
//         ),
//         body: Container(
//             child: Stack(children: [
//           ARView(
//             onARViewCreated: onARViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
//           ),
//           Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: onRemoveEverything,
//                       child: Text("Remove Everything")),
//                 ]),
//           ),
//           Align(
//             alignment: FractionalOffset.topCenter,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Visibility(
//                       visible: readyToUpload,
//                       child: ElevatedButton(
//                           onPressed: onUploadButtonPressed,
//                           child: Text("Upload"))),
//                   Visibility(
//                       visible: readyToDownload,
//                       child: ElevatedButton(
//                           onPressed: onDownloadButtonPressed,
//                           child: Text("Download"))),
//                 ]),
//           )
//         ])));
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;
//     this.arLocationManager = arLocationManager;

//     this.arSessionManager!.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: "Images/triangle.png",
//           showWorldOrigin: true,
//         );
//     this.arObjectManager!.onInitialize();
//     this.arAnchorManager!.initGoogleCloudAnchorMode();

//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager!.onNodeTap = onNodeTapped;
//     this.arAnchorManager!.onAnchorUploaded = onAnchorUploaded;

//     this
//         .arLocationManager
//         !.startLocationUpdates()
//         .then((value) => null)
//         .onError((error, stackTrace) {
//       switch (error.toString()) {
//         case 'Location services disabled':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please enable your location services",
//                 "Settings",
//                 this.arLocationManager!.openLocationServicesSettings,
//                 "Cancel");
//             break;
//           }

//         case 'Location permissions denied':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please allow the app to access your device's location",
//                 "Retry",
//                 this.arLocationManager!.startLocationUpdates,
//                 "Cancel");
//             break;
//           }

//         case 'Location permissions permanently denied':
//           {
//             showAlertDialog(
//                 context,
//                 "Action Required",
//                 "To use cloud anchor functionality, please allow the app to access your device's location",
//                 "Settings",
//                 this.arLocationManager!.openAppPermissionSettings,
//                 "Cancel");
//             break;
//           }

//         default:
//           {
//             this.arSessionManager!.onError(error.toString());
//             break;
//           }
//       }
//       this.arSessionManager!.onError(error.toString());
//     });
//   }

//   Future<void> onRemoveEverything() async {
//     anchors.forEach((anchor) {
//       this.arAnchorManager!.removeAnchor(anchor);
//     });
//     anchors = [];
//     if (lastUploadedAnchor != "") {
//       setState(() {
//         readyToDownload = true;
//         readyToUpload = false;
//       });
//     } else {
//       setState(() {
//         readyToDownload = true;
//         readyToUpload = false;
//       });
//     }
//   }

//   Future<void> onNodeTapped(List<String> nodeNames) async {
//     var foregroundNode =
//         nodes.firstWhere((element) => element.name == nodeNames.first);
//     this.arSessionManager!.onError(foregroundNode.data!["onTapText"]);
//   }

//   Future<void> onPlaneOrPointTapped(
//       List<ARHitTestResult> hitTestResults) async {
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
//     if (singleHitTestResult != null) {
//       var newAnchor = ARPlaneAnchor(
//           transformation: singleHitTestResult.worldTransform, ttl: 2);
//       bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
//       if (didAddAnchor ?? false) {
//         this.anchors.add(newAnchor);
//         // Add note to anchor
//         var newNode = ARNode(
//             type: NodeType.webGLB,
//             uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
//             scale: Vector3(0.2, 0.2, 0.2),
//             position: Vector3(0.0, 0.0, 0.0),
//             rotation: Vector4(1.0, 0.0, 0.0, 0.0),
//             data: {"onTapText": "Ouch, that hurt!"});
//         bool? didAddNodeToAnchor =
//             await this.arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
//         if (didAddNodeToAnchor ?? false) {
//           this.nodes.add(newNode);
//           setState(() {
//             readyToUpload = true;
//           });
//         } else {
//           this.arSessionManager!.onError("Adding Node to Anchor failed");
//         }
//       } else {
//         this.arSessionManager!.onError("Adding Anchor failed");
//       }
//     }
//   }

//   Future<void> onUploadButtonPressed() async {
//     this.arAnchorManager!.uploadAnchor(this.anchors.last);
//     setState(() {
//       readyToUpload = false;
//     });
//   }

  

 


//   void showAlertDialog(BuildContext context, String title, String content,
//       String buttonText, Function buttonFunction, String cancelButtonText) {
//     // set up the buttons
//     Widget cancelButton = ElevatedButton(
//       child: Text(cancelButtonText),
//       onPressed: () {
//         context.pop();
//       },
//     );
//     Widget actionButton = ElevatedButton(
//       child: Text(buttonText),
//       onPressed: () {
//         buttonFunction();
//         context.pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [
//         cancelButton,
//         actionButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }

