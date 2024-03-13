import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'front_cam_recording_state.dart';
part 'front_cam_recording_cubit.freezed.dart';

class FrontCamRecordingCubit extends Cubit<FrontCamRecordingState> {
  late List<CameraDescription> _cameras;
  late CameraController controller;
  FrontCamRecordingCubit() : super(const FrontCamRecordingState.initial());

  void initCameras() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.medium);
    // controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    controller.initialize().then((_) {
      // startVideoRecording();
      // setState(() {
      //   startVideoRecording();
      // });
      emit(state.copyWith(status: RecordingStatus.notRecording));
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            emit(state.copyWith(
                status: RecordingStatus.error,
                errorMsg:
                    'Please Manually allow the camera and mic permission for kids APP'));
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      emit(state.copyWith(
          status: RecordingStatus.error,
          errorMsg: 'Error: select a camera first.'));
      // Constants().showAppSnackbar(context, 'Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      emit(state.copyWith(status: RecordingStatus.recording));

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
        debugPrint('${file?.path}');
        // IOS doesn't support accesing this directory
        if (file != null && Platform.isAndroid) {
          debugPrint('Video recorded to ${file.path}');
          final directory = (await getExternalStorageDirectories(
                  type: StorageDirectory.downloads))!
              .first;

          if (directory != null) {
            // Create a file object with the desired file path
            File newFile = File('${directory.path}/test.mp4');

            // Copy the recorded video file to the new file location
            await file.saveTo(newFile.path);
            debugPrint('${directory.path}/test.mp4');
            emit(state.copyWith(status: RecordingStatus.recordingEnd));
            // Constants()
            //     .showAppSnackbar(context, 'ViVdeo recorded to ${file.path}');
          }
        }
      });
    } on CameraException catch (e) {
      debugPrint(e.description);

      // _showCameraException(e);
      return null;
    }
  }

  void dispose() {
    controller.dispose();
  }
}
