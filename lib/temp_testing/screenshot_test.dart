// import 'dart:async';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:size_config/size_config.dart';

// class ScreenShotTest extends StatefulWidget {
//   const ScreenShotTest({super.key});

//   @override
//   ScreenShotTestState createState() => ScreenShotTestState();
// }

// class ScreenShotTestState extends State<ScreenShotTest> {
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image; //for captured image
//   ScreenshotController screenshotController = ScreenshotController();

//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }

//   loadCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![0], ResolutionPreset.max);

//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     } else {
//       debugPrint("NO any camera found");
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         // ClippedContainer(),
//         SizedBox(
//             child: controller == null
//                 ? const Center(child: Text("Loading Camera..."))
//                 : !controller!.value.isInitialized
//                     ? const Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : CameraPreview(controller!)),

//         Transform.translate(
//           offset: Offset(0, -size.height * 0.08),
//           child: Align(
//             alignment: Alignment.center,
//             child: Screenshot(
//               controller: screenshotController,
//               child: Container(
//                   height: 100.h,
//                   width: 70.wp,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white, width: 5.0),
//                     borderRadius: BorderRadius.circular(12),
//                     // color: Colors.amberAccent,
//                   ),
//                   child: Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     color: Colors.transparent,
//                   )),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: FloatingActionButton(
//             shape: const CircleBorder(),
//             child: const Icon(Icons.camera),
//             onPressed: () {
//               // screenshotController.captureAsUiImage();
//               screenshotController
//                   .capture(delay: const Duration(milliseconds: 100))
//                   .then((capturedImage) async {
//                 showCapturedWidget(context, capturedImage!);
//               }).catchError((onError) {
//                 debugPrint(onError);
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Future<dynamic> showCapturedWidget(
//       BuildContext context, Uint8List capturedImage) {
//     debugPrint(capturedImage.toString());
//     return showDialog(
//       useSafeArea: false,
//       context: context,
//       builder: (context) => Scaffold(
//         appBar: AppBar(
//           title: const Text("Captured widget screenshot"),
//         ),
//         backgroundColor: Colors.red,
//         body: Center(child: Image.memory(capturedImage)),
//       ),
//     );
//   }
// }
