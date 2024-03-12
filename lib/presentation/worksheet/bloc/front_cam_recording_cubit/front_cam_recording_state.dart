part of 'front_cam_recording_cubit.dart';

enum RecordingStatus { recording, recordingEnd, notRecording }

@freezed
class FrontCamRecordingState with _$FrontCamRecordingState {
  const factory FrontCamRecordingState.initial({
    @Default(RecordingStatus.notRecording) RecordingStatus status,
  }) = CamRecordingState;
}
