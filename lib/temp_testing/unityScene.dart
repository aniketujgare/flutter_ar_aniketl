// import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:permission_handler/permission_handler.dart';

// class UnitySceneScreen extends StatefulWidget {
//   const UnitySceneScreen({Key? key}) : super(key: key);

//   @override
//   State<UnitySceneScreen> createState() => _UnitySceneScreenState();
// }

// class _UnitySceneScreenState extends State<UnitySceneScreen> {
//   static final GlobalKey<ScaffoldState> _scaffoldKey =
//       GlobalKey<ScaffoldState>();

//   UnityWidgetController? _unityWidgetController;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _unityWidgetController?.dispose();
//     super.dispose();
//   }

//   void requestPermissions() async {
//     var cameraStatus = await Permission.camera.status;
//     if (!cameraStatus.isGranted) {
//       await Permission.camera.request();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('Unity Sample Screen'),
//       ),
//       body: UnityWidget(
//         onUnityCreated: _onUnityCreated,
//         onUnityMessage: onUnityMessage,
//         onUnitySceneLoaded: onUnitySceneLoaded,
//         useAndroidViewSurface: true,
//         // borderRadius: const BorderRadius.all(Radius.circular(70)),
//       ),
//     );
//   }

//   void onUnityMessage(message) {
//     print('Received message from unity: ${message.toString()}');
//   }

//   void onUnitySceneLoaded(SceneLoaded? scene) async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.microphone,
//     ].request();
//     if (scene != null) {
//       print('Received scene loaded from unity: ${scene.name}');
//       print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
//     } else {
//       print('Received scene loaded from unity: null');
//     }
//   }

//   // Callback that connects the created controller to the unity controller
//   void _onUnityCreated(controller) {
//     controller.resume();
//     _unityWidgetController = controller;
//   }
// }
