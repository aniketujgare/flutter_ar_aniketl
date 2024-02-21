import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:size_config/size_config.dart';

class ScreenShotTest extends StatefulWidget {
  const ScreenShotTest({super.key});

  @override
  ScreenShotTestState createState() => ScreenShotTestState();
}

class ScreenShotTestState extends State<ScreenShotTest> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      // cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      debugPrint("NO any camera found");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future _cropImage(XFile imageFile) async {
    final double cropWidth =
        MediaQuery.of(context).size.width * 0.7; // 80% of screen width
    final double cropHeight =
        MediaQuery.of(context).size.height * 0.1; // 50% of screen height
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(
        ratioX: cropWidth,
        ratioY: cropHeight,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Resize text in rectangle",
          showCropGrid: false,
          hideBottomControls: true,
        )
      ],
    );
    if (croppedFile != null) {
      debugPrint('image cropped');
      File image = File(croppedFile.path);
      //Todo: Add API for sending image to backend
      debugPrint(croppedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // ClippedContainer(),
        SizedBox(
            child: controller == null
                ? const Center(child: Text("Loading Camera..."))
                : !controller!.value.isInitialized
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CameraPreview(controller!)),

        Transform.translate(
          offset: Offset(0, -size.height * 0.08),
          child: Align(
            alignment: Alignment.center,
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                  height: 100.h,
                  width: 70.wp,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5.0),
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.amberAccent,
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.transparent,
                  )),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            shape: CircleBorder(),
            child: const Icon(Icons.camera),
            onPressed: () {
              // screenshotController.captureAsUiImage();
              screenshotController
                  .capture(delay: const Duration(milliseconds: 100))
                  .then((capturedImage) async {
                ShowCapturedWidget(context, capturedImage!);
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
        ),
      ],
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    print(capturedImage);
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        backgroundColor: Colors.red,
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}

class ClippedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CustomPaint(
          size: Size(300, 300), // Set the size of the rectangle
          painter: ClippedRectanglePainter(),
        ),
      ),
    );
  }
}

class ClippedRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rectSize = Size(200, 100); // Size of the clipped rectangle
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2), // Center of the canvas
      width: rectSize.width,
      height: rectSize.height,
    );

    final paint = Paint()
      ..color = Colors.black // Color of the clipped rectangle
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.clipRect(rect);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
