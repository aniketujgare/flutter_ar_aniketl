part of 'front_cam_recording_cubit.dart';

enum RecordingStatus { initial, recording, recordingEnd, notRecording, error }

@freezed
class FrontCamRecordingState with _$FrontCamRecordingState {
  const factory FrontCamRecordingState.initial({
    @Default(RecordingStatus.notRecording) RecordingStatus status,
    @Default('Please Manually allow the camera and mic permission for kids APP')
    String errorMsg,
  }) = CamRecordingState;
}
