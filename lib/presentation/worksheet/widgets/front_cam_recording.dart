import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/constants.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:size_config/size_config.dart';

late List<CameraDescription> _cameras;

/// CameraApp is the Main Application.
class FrontCamRecording extends StatefulWidget {
  /// Default Constructor
  const FrontCamRecording({super.key});

  @override
  State<FrontCamRecording> createState() => _FrontCamRecordingState();
}

class _FrontCamRecordingState extends State<FrontCamRecording> {
  late CameraController controller;
  _initCameras() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.medium);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      // startVideoRecording();
      setState(() {
        startVideoRecording();
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Container(
      height: 130.h,
      width: 135.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CameraPreview(
            controller,
            child: Container(
              height: 100.h,
              width: 135.h,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.primaryColor, width: 4.h)),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.small(
                  child: const Icon(Icons.stop),
                  onPressed: () => stopVideoRecording()))
        ],
      ),
    );
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      Constants().showAppSnackbar(context, 'Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      debugPrint(e.description);
      // _showCameraException(e);
      return;
    }
  }

  Future<void> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.stopVideoRecording().then((XFile? file) async {
        if (file != null) {
          debugPrint('Video recorded to ${file.path}');
          final directory = (await getExternalStorageDirectories(
                  type: StorageDirectory.downloads))!
              .first;
// Check if the directory is available
          if (directory != null) {
            // Create a file object with the desired file path
            File newFile = File('${directory.path}/test.mp4');

            // Copy the recorded video file to the new file location
            await file.saveTo(newFile.path);
            debugPrint('${directory.path}/test.mp4');
            Constants()
                .showAppSnackbar(context, 'Video recorded to ${file.path}');
          }
        }
      });
    } on CameraException catch (e) {
      debugPrint(e.description);

      // _showCameraException(e);
      return null;
    }
  }
}
