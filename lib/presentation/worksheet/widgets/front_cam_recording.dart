import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/core/util/constants.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/worksheet/bloc/front_cam_recording_cubit/front_cam_recording_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:size_config/size_config.dart';

// late List<CameraDescription> _cameras;

/// CameraApp is the Main Application.
class FrontCamRecording extends StatefulWidget {
  /// Default Constructor
  const FrontCamRecording({super.key});

  @override
  State<FrontCamRecording> createState() => _FrontCamRecordingState();
}

class _FrontCamRecordingState extends State<FrontCamRecording> {
  // late CameraController controller;
  // _initCameras() async {
  //   _cameras = await availableCameras();
  //   controller = CameraController(_cameras[1], ResolutionPreset.medium);

  //   controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     // startVideoRecording();
  //     setState(() {
  //       startVideoRecording();
  //     });
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           // Handle access errors here.
  //           break;
  //         default:
  //           // Handle other errors here.
  //           break;
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // context.read<FrontCamRecordingCubit>().initCameras();
    // context.read<FrontCamRecordingCubit>().startVideoRecording();

    // _initCameras();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FrontCamRecordingCubit, FrontCamRecordingState>(
      listener: (context, state) {
        print('Camera State: ${state.status}');
        // TODO: implement listener
        if (state.status == RecordingStatus.notRecording) {
          context.read<FrontCamRecordingCubit>().startVideoRecording();
        }
        if (state.status == RecordingStatus.recordingEnd) {
          Constants().showAppSnackbar(
              context, 'Video Recording Saved to Apps Data Directory.');
        }
        if (state.status == RecordingStatus.error) {
          Constants().showAppSnackbar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 130.h,
          width: 135.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CameraPreview(
                context.read<FrontCamRecordingCubit>().controller,
                child: Container(
                  height: 100.h,
                  width: 135.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor, width: 4.h)),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.small(
                      child: const Icon(Icons.drag_handle),
                      onPressed: () => VoidCallback
                      // context
                      //     .read<FrontCamRecordingCubit>()
                      //     .stopVideoRecording()
                      ))
            ],
          ),
        );
      },
    );
  }

//   Future<void> startVideoRecording() async {
//     final CameraController? cameraController = controller;

//     if (cameraController == null || !cameraController.value.isInitialized) {
//       Constants().showAppSnackbar(context, 'Error: select a camera first.');
//       return;
//     }

//     if (cameraController.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return;
//     }

//     try {
//       await cameraController.startVideoRecording();
//     } on CameraException catch (e) {
//       debugPrint(e.description);
//       // _showCameraException(e);
//       return;
//     }
//   }

//   Future<void> stopVideoRecording() async {
//     final CameraController? cameraController = controller;

//     if (cameraController == null || !cameraController.value.isRecordingVideo) {
//       return;
//     }

//     try {
//       await cameraController.stopVideoRecording().then((XFile? file) async {
//         if (file != null) {
//           debugPrint('Video recorded to ${file.path}');
//           final directory = (await getExternalStorageDirectories(
//                   type: StorageDirectory.downloads))!
//               .first;
// // Check if the directory is available
//           if (directory != null) {
//             // Create a file object with the desired file path
//             File newFile = File('${directory.path}/test.mp4');

//             // Copy the recorded video file to the new file location
//             await file.saveTo(newFile.path);
//             debugPrint('${directory.path}/test.mp4');
//             Constants()
//                 .showAppSnackbar(context, 'Video recorded to ${file.path}');
//           }
//         }
//       });
//     } on CameraException catch (e) {
//       debugPrint(e.description);

//       // _showCameraException(e);
//       return null;
//     }
//   }
}
